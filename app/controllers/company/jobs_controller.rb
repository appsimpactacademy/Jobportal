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
      if @job.inactive_for_job_seekers?
        users = @job.applied_jobs
                    .joins(job_seeker: :notification_setting)
                    .where(notification_settings: { on_status_changed_on_applied_job: true })
                    .map(&:job_seeker)
        if users.present?
          users.each do |user|
            NotificationMailer.when_an_applied_job_status_changed(user, @job).deliver_now
          end
        end
      end
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
