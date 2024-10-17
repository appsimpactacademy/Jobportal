class ExportMailer < ApplicationMailer
  def send_exported_job_applications(user, data, job, export_format)
    @user = user
    @job = job
    @export_format = export_format.upcase
    mime_type = @export_format == 'xls' ? 'application/vnd.ms-excel' : 'text/csv'
    attachments["job-applications-#{Date.today}.#{export_format}"] = { mime_type: mime_type, content: data }
    mail(to: @user.email, subject: "You job application #{@export_format} export for #{@job.title}")
  end
end
