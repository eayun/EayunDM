class RemoveResourceIdFromPermissions < ActiveRecord::Migration
  def change
    remove_column :permissions, :resource_id, :string
  end
end
