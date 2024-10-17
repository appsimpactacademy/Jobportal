# Preview all emails at http://localhost:3000/rails/mailers/export_mailer
class ExportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/export_mailer/send_exported_job_applications
  def send_exported_job_applications
    ExportMailer.send_exported_job_applications
  end

end
