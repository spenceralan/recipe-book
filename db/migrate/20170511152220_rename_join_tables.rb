class RenameJoinTables < ActiveRecord::Migration[5.1]
  def change
    rename_table :ingredients_recipes, :recipe_ingredients
    rename_table :recipes_tags, :recipe_tags
  end
end
