class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :profile_id
      t.string :country
      t.string :city
      t.string :street
      t.string :house_number

      t.timestamps null: false
    end
  end
end
