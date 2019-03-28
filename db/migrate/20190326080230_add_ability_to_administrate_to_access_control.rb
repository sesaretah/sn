class AddAbilityToAdministrateToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :ability_to_administrate, :boolean
  end
end
