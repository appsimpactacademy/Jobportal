class ExportJobApplicationsJob < ApplicationJob
  queue_as :default

  def perform(user, job, search_params, export_format='csv')
    applied_jobs = job.applied_jobs
                      .includes(:job_seeker)
                      .filter_applications(search_params)
    if export_format == 'csv'
      data = Csv::ExportJobApplicationsService.new(applied_jobs).generate_csv
    elsif export_format == 'xls'
      data = Excel::ExportJobApplicationsService.new(applied_jobs, job).generate_excel
    end
    ExportMailer.send_exported_job_applications(user, data, job, export_format).deliver_now
  end
end
