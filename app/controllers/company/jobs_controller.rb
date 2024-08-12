class Company::JobsController < ApplicationController
  before_action :authenticate_user!

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
      render :new
    end
  end

  def show
    @job = current_company.jobs.find(params[:id])
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :posted_by_id, :applicable_for, :job_type, :job_location, :salary_range, :total_positions, :status)
  end
end
