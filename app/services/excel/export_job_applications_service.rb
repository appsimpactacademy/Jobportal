require 'spreadsheet'

class Excel::ExportJobApplicationsService
  def initialize(applied_jobs, job)
    @applied_jobs = applied_jobs
    @job = job
  end

  def generate_excel
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet(name: "Job applications received for #{@job.title}")
    sheet.row(0).concat(excel_headers)

    @applied_jobs.each_with_index do |applied_job, index|
      sheet.row(index+1).replace excel_row(applied_job)
    end

    excel_data = StringIO.new
    book.write(excel_data)
    excel_data.string
  end

  private

  def excel_headers
    ['ID', 'Applicant Name', 'Applicant Email', 'Contact Number', 'Current CTC', 'Expected CTC', 'When Able to Join', 'Serving Notice', 'Applied At']
  end

  def excel_row(applied_job)
    [
      applied_job.id,
      applied_job.job_seeker.name,
      applied_job.job_seeker.email,
      applied_job.contact_number,
      applied_job.current_ctc,
      applied_job.expected_ctc,
      applied_job.estimated_joining_within,
      applied_job.serving_notice_period ? 'Yes' : 'No',
      applied_job.created_at.strftime("%Y-%m-%d")
    ]
  end
end
