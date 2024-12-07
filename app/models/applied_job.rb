class AppliedJob < ApplicationRecord
  JOINING_DURATION = ['Immediate', '1 Week', '15 Days', '1 Month', '2 Month']

  belongs_to :job
  belongs_to :job_seeker, class_name: 'User', foreign_key: 'user_id'

  validates :cover_letter, :expected_ctc, :current_ctc, :contact_number, presence: true

  # callbacks

  after_create :notify_employers_and_job_seekers

  # class methods

  def self.filter_applications(params)
    if params[:joining_duration].present? && params[:serving_notice].present?
      where(estimated_joining_within: params[:joining_duration], serving_notice_period: params[:serving_notice])
    else
      all
    end
  end

  private

  def notify_employers_and_job_seekers
    AppliedJobNotificationJob.perform_later(job_seeker, job)
  end
end
