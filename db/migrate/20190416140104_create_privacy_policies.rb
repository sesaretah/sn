class CreatePrivacyPolicies < ActiveRecord::Migration
  def change
    create_table :privacy_policies do |t|
      t.integer :user_id
      t.integer :ability_to_view_educations
      t.integer :ability_to_view_shares
      t.integer :ability_to_view_bookmarks

      t.timestamps null: false
    end
  end
end
