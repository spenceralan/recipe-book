ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')
#this line allows uuids to work if the proper gem is not previously installed -spencer

class CreateRecipesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes, id: :uuid do |t|
      t.column :name, :string
      t.column :instructions, :text
      t.column :rating, :integer
    end
  end
end
