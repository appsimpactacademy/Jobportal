class AppliedJobNotificationJob < ApplicationJob
  queue_as :applied_job_notification

  def perform(job_seeker, job)
    NotificationMailer.job_application_receive_to_employeer(job_seeker, job).deliver_now
    NotificationMailer.job_applied_by_job_seeker(job_seeker, job).deliver_now
  end
end
