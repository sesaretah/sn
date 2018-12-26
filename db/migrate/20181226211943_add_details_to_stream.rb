class AddDetailsToStream < ActiveRecord::Migration
  def change
    add_column :streams, :details, :text
  end
end
