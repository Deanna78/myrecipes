class AddGroupsToRecipes < ActiveRecord::Migration[5.1]
  def change
      add_column :recipes, :group, :string
  end
end
