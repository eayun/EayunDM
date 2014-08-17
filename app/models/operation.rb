class Operation < ActiveRecord::Base
  has_many :role_operations
  has_many :roles, :through => :role_operations, :dependent => :delete_all
  validates_presence_of :name
end
