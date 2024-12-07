class ApplicationController < ActionController::Base
  
  private

  def authorize_company_user
    if user_signed_in? && current_user.employer?
      current_company
    else
      redirect_to root_path, notice: 'You are not authorized to access this section'
    end
  end

  def current_company
    if user_signed_in? && current_user.employer?
      current_user.company
    end
  end

  def current_employer
    if user_signed_in? && current_user.employer?
      current_user
    end
  end
end
