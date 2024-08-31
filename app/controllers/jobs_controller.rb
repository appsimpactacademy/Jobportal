class JobsController < ApplicationController
  def index
    if params[:type].present?
      @q = Job.active_jobs.send("#{params[:type]}_jobs").ransack(params[:q])
    else
      @q = Job.active_jobs.ransack(params[:q])
    end
    @jobs = @q.result
  end

  def show
    @job = Job.active_jobs.find_by(uuid: params[:id])
  end
end
