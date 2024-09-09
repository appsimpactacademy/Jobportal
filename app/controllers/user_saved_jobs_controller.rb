class UserSavedJobsController < ApplicationController
  before_action :authenticate_user!

  def create
    @job = Job.find_by(uuid: params[:job_id])
    @saved_job = current_user.user_saved_jobs.new(job_id: @job.id)
    if @saved_job.save
      redirect_to jobs_path
    end
  end
end
