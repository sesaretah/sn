class AddUuidToNotify < ActiveRecord::Migration
  def change
    add_column :notifies, :uuid, :string
  end
end
