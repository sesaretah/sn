class ChangeDeafultInNotficationSetting2 < ActiveRecord::Migration
  def change
    change_column :notification_settings, :notify_people_shares, :string
  end
end
