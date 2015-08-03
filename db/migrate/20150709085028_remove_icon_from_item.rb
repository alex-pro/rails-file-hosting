class RemoveIconFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :icon, :string
  end
end
