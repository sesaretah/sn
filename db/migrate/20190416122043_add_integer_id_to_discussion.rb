class AddIntegerIdToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :integer_id, :integer
  end
end
