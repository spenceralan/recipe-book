class CreateTagsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :tags, id: :uuid do |t|
      t.column :name, :string
    end
  end
end
