class AddFotoToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :photo, :string
    add_column :profiles, :birthday, :datetime
  end
end
