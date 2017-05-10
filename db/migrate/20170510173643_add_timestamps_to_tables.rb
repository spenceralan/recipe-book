class AddTimestampsToTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :ingredients
    drop_table :recipes
    drop_table :tags
    create_table :ingredients, id: :uuid do |t|
      t.column :name, :string
      t.timestamps
    end
    create_table :tags, id: :uuid do |t|
      t.column :name, :string
      t.timestamps
    end
    create_table :recipes, id: :uuid do |t|
      t.column :name, :string
      t.column :instructions, :text
      t.column :rating, :integer
      t.timestamps
    end
  end
end
