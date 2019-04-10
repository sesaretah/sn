class NotificationSettingsController < ApplicationController
  def change
    @notification_setting = current_user.notification_settings.first
    if @notification_setting.blank?
      @notification_setting = NotificationSetting.create(user_id: current_user.id)
    end
    @cl = @notification_setting.send(params[:cl]).to_s
    if params[:to] == 'check'
      case
      when params[:p] == 'pushweb'
        @notification_setting[params[:cl]] = @cl[0..1] + '1'
      when params[:p] == 'pushmobile'
        @notification_setting[params[:cl]] = @cl[0] + '1' + @cl[2]
      when params[:p] == 'pushemail'
        @notification_setting[params[:cl]] = '1' + @cl[1..2]
      end
    else
      case
      when params[:p] == 'pushweb'
        @notification_setting[params[:cl]] = @cl[0..1] + '0'
      when params[:p] == 'pushmobile'
        @notification_setting[params[:cl]] = @cl[0] + '0' + @cl[2]
      when params[:p] == 'pushemail'
        @notification_setting[params[:cl]] = '0' + @cl[1..2]
      end
    end
    @notification_setting.save
  end
end
