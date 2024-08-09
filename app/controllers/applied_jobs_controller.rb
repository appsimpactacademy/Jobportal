class AppliedJobsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find_by(uuid: params[:job_id])
    @job_application = AppliedJob.new
  end

  def create
  end
end
