class AppliedJobsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find_by(uuid: params[:job_id])
    @job_application = AppliedJob.new
  end

  def create
    @applied_job = current_user.applied_jobs.new(apply_job_params)
    if @applied_job.save
      redirect_to my_saved_jobs_user_saved_jobs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def apply_job_params
    params.require(:applied_job).permit(:job_id, :current_ctc, :expected_ctc, :cover_letter, :contact_number, :estimated_joining_within, :serving_notice_period)
  end
end
