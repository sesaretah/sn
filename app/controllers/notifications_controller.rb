class NotificationsController < ApplicationController

  def search

  end
  
  def index
    extract_notifications(1)
    @page = 1
  end

  def more
    extract_notifications(params[:page])
    @page = params[:page]
  end

  def extract_notifications(page)
    @notifications = current_user.notifications.order('created_at desc').paginate(:page => page, per_page: 10).order('created_at desc')
  end
end
