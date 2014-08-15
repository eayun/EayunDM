class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role_id
      t.integer :user_id
      t.string :resource_id

      t.timestamps
    end
  end
end
