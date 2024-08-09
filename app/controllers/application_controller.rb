class ApplicationController < ActionController::Base
  
  private

  def current_company
    if user_signed_in? && current_user.employeer?
      current_user.company
    end
  end

  def current_employeer
    if user_signed_in? && current_user.employeer?
      current_user
    end
  end
end
