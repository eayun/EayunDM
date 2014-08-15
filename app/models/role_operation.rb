class RoleOperation < ActiveRecord::Base
    belongs_to :role
    belongs_to :operation
end
