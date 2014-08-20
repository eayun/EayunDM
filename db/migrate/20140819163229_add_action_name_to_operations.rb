class AddActionNameToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :action_name, :string
  end
end
