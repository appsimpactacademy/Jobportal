class NotificationMailer < ApplicationMailer

  def when_new_job_created(users, job)
    # @user = user
    @job = job

    mail(to: users, subject: "A new job posted: #{@job.title}")
  end
end
