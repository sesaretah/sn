class AddIsRobotToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_robot, :boolean
  end
end
