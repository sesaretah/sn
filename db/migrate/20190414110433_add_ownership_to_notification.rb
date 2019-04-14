class AddOwnershipToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :ownership, :string
  end
end
