class DemoEmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.demo_email_mailer.user_count.subject
  #
  def user_count(total_users, job_count, application_count)
    @greeting = "Hi you have total of #{job_count} jobs, #{total_users} users, #{application_count} job applications"

    mail to: "to@example.org"
  end
end
