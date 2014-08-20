class AddResourceClassToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :resource_class, :string
  end
end
