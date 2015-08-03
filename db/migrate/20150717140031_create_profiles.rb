class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
    add_index :profiles, :user_id
    add_index :profiles, :name
  end
end
