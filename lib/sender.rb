module Sender
  include Mailservice
  include Webpush
  def send_by_settings(notification, user, option)
    @notification = notification
    @notification_setting = user.notification_settings.first
    if @notification_setting[option][0] == '1'
      send_mail(user.email, 'آگاهسازی', "#{notification.title} #{notification.body.truncate(27)}", 'https://sn.ut.ac.ir/notifications')
    end
    if @notification_setting[option][1] == '1'

    end
    if @notification_setting[option][2] == '1'
      @client = Client.where(user_id: user.id, client_type: 'socket').last
      if !@client.blank?
        send_web(@client.uuid, @notification.title, @notification.body)
      end
    end
  end
end
