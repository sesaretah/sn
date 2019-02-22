class AddGradLevelToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :grad_level, :string
  end
end
