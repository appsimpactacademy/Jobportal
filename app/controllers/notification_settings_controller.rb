class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def manage_notification_settings
    if current_user.notification_setting.present?
      @setting = current_user.notification_setting
    else
      @setting = current_user.build_notification_setting
    end
  end

  def create
    @setting = current_user.build_notification_setting(setting_params)
    if @setting.save
      redirect_to settings_path
    else
      render :manage_notification_settings, status: :unprocessable_entity
    end
  end

  private

  def setting_params
    params.permit(:on_new_job_post, :on_removal_of_favourite_job, :on_removal_of_existing_job, :on_status_changed_on_applied_job, :on_job_status_change)
  end
end