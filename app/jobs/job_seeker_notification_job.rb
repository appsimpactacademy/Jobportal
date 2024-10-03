class JobSeekerNotificationJob < ApplicationJob
  queue_as :default

  def perform(job, action_name=nil)
    if action_name == 'create'
      notifiable_users = User.where(role: 'job_seeker')
                             .joins(:notification_setting)
                             .where(notification_settings: { on_new_job_post: true })
      notifiable_users.each do |user|
        NotificationMailer.when_new_job_created(user, job).deliver_now
      end if notifiable_users.present?
    elsif action_name == 'update'
      applied_jobs = job.applied_jobs
      notifiable_users = applied_jobs.joins(job_seeker: :notification_setting)
                                     .where(notification_settings: { on_status_changed_on_applied_job: true })
                                     .map(&:job_seeker)
      notifiable_users.each do |user|
        NotificationMailer.when_an_applied_job_status_changed(user, job).deliver_now
      end if notifiable_users.present?
    end
  end
end
