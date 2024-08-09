class JobsController < ApplicationController
  def index
    if params[:type].present?
      @jobs = Job.includes(:company).send("#{params[:type]}_jobs")
    else
      @jobs = Job.includes(:company).find_each
    end
  end

  def show
    @job = Job.find(params[:id])
  end
end
