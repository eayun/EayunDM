class RoleOperation < ActiveRecord::Base
  belongs_to :role
  belongs_to :operation
  validates_uniqueness_of :role_id, :scope => [:operation_id]
end
