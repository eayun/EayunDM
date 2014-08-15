class Role < ActiveRecord::Base
    has_many :role_operations
    has_many :operations, :through => :role_operations
    has_many :permissions, :dependent => :delete_all
    has_many :users, :through => :permissions
    validates_presence_of :name
end
