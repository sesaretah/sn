class AddUuidToPrivacyPolicy < ActiveRecord::Migration
  def change
    add_column :privacy_policies, :uuid, :string
    add_index :privacy_policies, :uuid, unique: true
  end
end
