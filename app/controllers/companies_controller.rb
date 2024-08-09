class CompaniesController < ApplicationController
  def index
    @q = Company.includes(:jobs).ransack(params[:q])
    @companies = @q.result
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
  end
end
