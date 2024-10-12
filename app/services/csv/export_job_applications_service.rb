require 'csv'

class Csv::ExportJobApplicationsService
  def initialize(applied_jobs)
    @applied_jobs = applied_jobs
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_headers

      @applied_jobs.each do |applied_job|
        csv << csv_row(applied_job)
      end
    end
  end

  private

  def csv_headers
    ['ID', 'Applicant Name', 'Applicant Email', 'Contact Number', 'Current CTC', 'Expected CTC', 'When Able to Join', 'Serving Notice', 'Applied At']
  end

  def csv_row(applied_job)
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
