class AddFolderIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :folder_id, :integer
  end
end
