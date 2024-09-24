class NotificationMailer < ApplicationMailer

  def when_new_job_created(user, job)
    @user = user
    @job = job

    mail(to: @user.email, subject: "A new job posted: #{@job.title}")
  end
end
