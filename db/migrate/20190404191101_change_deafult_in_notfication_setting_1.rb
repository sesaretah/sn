class ChangeDeafultInNotficationSetting1 < ActiveRecord::Migration
  def change
    change_column :notification_settings, :notify_people_shares, :string, :default => '000'
  end
end
