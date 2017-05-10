class CreateJoinTables < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients_recipes, id: :uuid do |t|
      t.column :recipe_id, :uuid
      t.column :ingredient_id, :uuid
      t.timestamps
    end
    create_table :recipes_tags, id: :uuid do |t|
      t.column :recipe_id, :uuid
      t.column :tag_id, :uuid
      t.timestamps
    end
  end
end
