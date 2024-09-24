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
      # find all the users with notification setting present and selected the option for receive the notification when new job posted
      if @job.active?
        users = User.joins(:notification_setting)
                    .where(notification_settings: { on_new_job_post: true })
        if users.present?
          users.each do |user|
            # send email to users one by one
            NotificationMailer.when_new_job_created(user, @job).deliver_now
          end
        end
      end
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
    @job.destroy
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
