class Company::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company_user
  before_action :load_job, only: %i[show edit destroy update export_job_applications]

  def index
    @jobs = current_company.jobs.includes(:applied_jobs)
  end

  def new
    @job = current_company.jobs.new
  end

  def create
    @job = current_company.jobs.new(job_params)
    if @job.save
      redirect_to company_jobs_path, notice: 'Job created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @applied_jobs = @job.applied_jobs
                        .includes(:job_seeker)
                        .filter_applications(search_params)
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to company_jobs_path, notice: 'Job updated successfully'
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
    redirect_to company_jobs_path, alert: 'Job deleted successfully'
  end

  def export_job_applications
    ExportJobApplicationsJob.perform_later(current_user, @job, search_params, params[:as])
    respond_to do |format|
      format.html { redirect_to company_job_path(@job, joining_duration: params[:joining_duration], serving_notice: params[:serving_notice], commit: params[:commit]), notice: "#{params[:as].upcase} is being generated and this will be send to your email." }
    end
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
