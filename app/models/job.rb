class Job < ApplicationRecord

  JOB_TYPE = ['Contract', 'Fulltime', 'Part time', 'Internship'].freeze
  JOB_LOCATION = ['Remote', 'Onsite']
  APPLICABLE_FOR = ['Freshers', 'Intermediate', 'Experienced', 'Expert', 'Open for all']
  SALARY_RANGE = ['$1000-$2500', '$2500-$5000', '$5000-$10000', '> $10000', 'Hourly']
  JOB_STATUS = ['Active', 'Inactive', 'Draft', 'Closed']

  has_many :applied_jobs
  has_many :user_saved_jobs, dependent: :destroy
  has_many :job_seekers, class_name: 'User', through: :user_saved_jobs

  belongs_to :company
  
  validates :title, presence: true, uniqueness: true
  validates :description, :job_location, :job_type, 
            :applicable_for, :salary_range, :total_positions, presence: true

  validates :status, presence: true, inclusion: { in: JOB_STATUS, message: "%{value} is not a valid status" }

  scope :remote_jobs, -> { where(job_location: 'Remote') }
  scope :onsite_jobs, -> { where(job_location: 'Onsite') }

  scope :active_jobs, -> { includes(:company).where(status: 'Active') }
  scope :inactive_jobs, -> { includes(:company).where(status: 'Inactive') }
  scope :draft_jobs, -> { includes(:company).where(status: 'Draft') }

  def posted_by
    User.where(role: 'employeer').find(posted_by_id)
  end

  # callbacks
  before_create :generate_uuid
  after_create :notify_job_seekers_on_new_job_post, if: :active?
  after_update :notify_job_seekers_on_status_changed_for_applied_job, if: :inactive_for_job_seekers?
  
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def to_param
    uuid
  end

  def active?
    self.status == 'Active'
  end

  def inactive_for_job_seekers?
    self.status != 'Active'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["applicable_for", "company_id", "created_at", "description", "id", "job_location", "job_type", "link_to_apply", "posted_by_id", "salary_range", "status", "title", "total_positions", "updated_at", "uuid"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["applied_jobs", "company"]
  end

  private

  def notify_job_seekers_on_new_job_post
    users = User.where(role: 'job_seeker')
                .joins(:notification_setting)
                .where(notification_settings: { on_new_job_post: true })
    users.each do |user|
      NotificationMailer.when_new_job_created(user, self).deliver_now
    end if users.present?
  end

  def notifiable_users
    applied_jobs.joins(job_seeker: :notification_setting)
                .where(notification_settings: { on_status_changed_on_applied_job: true })
                .map(&:job_seeker)
  end

  def notify_job_seekers_on_status_changed_for_applied_job
    notifiable_users.each do |user|
      NotificationMailer.when_an_applied_job_status_changed(user, self).deliver_now
    end if notifiable_users.present?
  end
end
