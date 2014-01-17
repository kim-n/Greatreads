class NotificationsController < ApplicationController
  before_filter :require_current_user!

  def index
    @notifications = current_user.notifications
    @new_notifications = current_user.new_notifications
    @new_notifications.each do |notice|
      notice.update_attribute("checked", true)
    end
    render :index
  end
end
