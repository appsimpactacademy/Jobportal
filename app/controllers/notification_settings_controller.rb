class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def manage_notification_settings
    if current_user.notification_setting.present?
      @setting = current_user.notification_setting
    else
      @setting = current_user.build_notification_setting
    end
  end
end