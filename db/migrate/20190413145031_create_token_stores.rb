class CreateTokenStores < ActiveRecord::Migration
  def change
    create_table :token_stores do |t|
      t.integer :user_id
      t.string :token

      t.timestamps null: false
    end
  end
end
