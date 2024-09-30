class UserSavedJobsController < ApplicationController
  before_action :authenticate_user!

  def create
    @job = Job.find_by(uuid: params[:job_id])
    @saved_job = current_user.user_saved_jobs.new(job_id: @job.id)
    if @saved_job.save
      redirect_to jobs_path
    end
  end

  def update
    @saved_job = current_user.user_saved_jobs.find(params[:id])
    if params[:add_to_saved_list].present?
      removed_at = nil
    else
      removed_at = DateTime.now
    end
    if @saved_job.update(removed_from_favourite_at: removed_at)
      redirect_to my_saved_jobs_user_saved_jobs_path
    end
  end

  def my_saved_jobs
    @saved_jobs = current_user.user_saved_jobs.includes(:job).where(removed_from_favourite_at: nil)
    @removed_saved_jobs = current_user.user_saved_jobs.includes(:job).where.not(removed_from_favourite_at: nil)
    @applied_jobs = current_user.applied_jobs
  end
end
