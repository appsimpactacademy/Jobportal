class NotificationSettingsController < ApplicationController
  def manage_notification_setting
    if current_user.notification_setting.present?
      @setting = current_user.notification_setting
    else
      @setting = current_user.build_notification_setting
    end
  end
end