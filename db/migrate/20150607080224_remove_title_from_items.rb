class RemoveTitleFromItems < ActiveRecord::Migration
  def change
    add_column :items, :name, :string

    create_table :folders do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
    add_index :folders, :user_id
  end
end
