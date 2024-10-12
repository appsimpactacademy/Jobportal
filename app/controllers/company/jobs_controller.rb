class Company::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company_user
  before_action :load_job, only: %i[show edit destroy update]

  def index
    @jobs = current_company.jobs
  end

  def new
    @job = current_company.jobs.new
  end

  def create
    @job = current_company.jobs.new(job_params)
    if @job.save
      redirect_to company_jobs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @applied_jobs = @job.applied_jobs
                        .includes(:job_seeker)
                        .filter_applications(search_params)
    respond_to do |format|
      format.html
      format.csv do 
        csv_data = Csv::ExportJobApplicationsService.new(@applied_jobs).generate_csv
        send_data csv_data, filename: "job-applications-#{Date.today}.csv"
      end
      format.xls do
        excel_data = Excel::ExportJobApplicationsService.new(@applied_jobs, @job).generate_excel
        send_data excel_data, filename: "job-applications-#{Date.today}.xls"
      end
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to company_jobs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @job.user_saved_jobs.present?
      users = @job.job_seekers
                  .joins(:notification_setting)
                  .where(notification_settings: { on_removal_of_favourite_job: true })
                  .to_a
      job_title = @job.title
      company = @job.company
    end
    notifiable_users = users.dup
    @job.destroy
    if notifiable_users.present?
      DeleteFavouriteJobNotificationJob.perform_later(notifiable_users, job_title, company)
    end
    redirect_to company_jobs_path
  end

  private

  def load_job
    @job = current_company.jobs.find_by(uuid: params[:id])
  end

  def search_params
    { joining_duration: params[:joining_duration], serving_notice: params[:serving_notice] }
  end

  def job_params
    params.require(:job).permit(:title, :description, :posted_by_id, :applicable_for, :job_type, :job_location, :salary_range, :total_positions, :status)
  end
end
