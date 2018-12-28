class AddColorToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :color, :string
  end
end
