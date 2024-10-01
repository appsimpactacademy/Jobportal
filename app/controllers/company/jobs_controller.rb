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
      notifiable_users.each do |user|
        NotificationMailer.when_a_user_favourite_job_removed(user, job_title, company).deliver_now
      end
    end
    redirect_to company_jobs_path
  end

  private

  def load_job
    @job = current_company.jobs.find_by(uuid: params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :posted_by_id, :applicable_for, :job_type, :job_location, :salary_range, :total_positions, :status)
  end
end
