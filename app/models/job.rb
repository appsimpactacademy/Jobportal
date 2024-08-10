class Job < ApplicationRecord

  JOB_TYPE = ['Contract', 'Fulltime', 'Part time', 'Internship'].freeze
  JOB_LOCATION = ['Remote', 'Onsite']
  APPLICABLE_FOR = ['Freshers', 'Intermediate', 'Experienced', 'Expert', 'Open for all']
  SALARY_RANGE = ['$1000-$2500', '$2500-$5000', '$5000-$10000', '> $10000', 'Hourly']

  has_many :applied_jobs
  belongs_to :company
  
  validates :title, presence: true, uniqueness: true
  validates :description, :job_location, :job_type, 
            :applicable_for, :salary_range, :total_positions, presence: true

  scope :remote_jobs, -> { where(job_location: 'Remote') }
  scope :onsite_jobs, -> { where(job_location: 'Onsite') }

  def posted_by
    User.where(role: 'employeer').find(posted_by_id)
  end

  before_create :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
