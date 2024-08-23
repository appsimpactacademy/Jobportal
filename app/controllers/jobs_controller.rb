class JobsController < ApplicationController
  def index
    if params[:type].present?
      @jobs = Job.includes(:company).send("#{params[:type]}_jobs").active_jobs
    else
      @jobs = Job.includes(:company).find_each
    end
  end

  def show
    @job = Job.active_jobs.find_by(uuid: params[:id])
  end
end
