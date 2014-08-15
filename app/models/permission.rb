class Permission < ActiveRecord::Base
    validates_presence_of :resource_id
end
