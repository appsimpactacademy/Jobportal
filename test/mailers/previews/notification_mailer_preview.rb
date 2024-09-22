# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/when_new_job_created
  def when_new_job_created
    NotificationMailer.when_new_job_created
  end

end
