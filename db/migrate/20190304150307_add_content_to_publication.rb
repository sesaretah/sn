class AddContentToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :content, :text
  end
end
