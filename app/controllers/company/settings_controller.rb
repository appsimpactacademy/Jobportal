class Company::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company_user

  def company_details
    @company = current_company
  end

  def update_company_info
    if current_company.update(company_params)
      redirect_to company_my_company_path, notice: "Company details updated successfully"
    else
      render :company_details, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(Company.params)
  end
end
