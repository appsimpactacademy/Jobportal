# Preview all emails at http://localhost:3000/rails/mailers/demo_email_mailer
class DemoEmailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/demo_email_mailer/user_count
  def user_count
    DemoEmailMailer.user_count
  end

end
