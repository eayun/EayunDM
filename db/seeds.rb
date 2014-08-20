# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create all operations
manage_all = Operation.create( :name => 'manage all resources', :action_name => 'manage', :resource_class => 'all' )
list_all = Operation.create( :name => 'list all resources', :action_name => 'index', :resource_class => 'all' )
show_all = Operation.create( :name => 'show all resources', :action_name => 'show', :resource_class => 'all' )
manage_user = Operation.create( :name => 'manage all users', :action_name => 'manage', :resource_class => 'user' )

# Create all roles
super_user = Role.create( :name => 'super user', :desc => 'rw everything' )
user_manager = Role.create( :name => 'user manager', :desc => 'manage all users' )
reporter = Role.create( :name => 'reporter', :desc => 'read everything' )

# Create role_operation mapping
RoleOperation.create( :role_id => super_user.id, :operation_id => manage_all.id )
RoleOperation.create( :role_id => reporter.id, :operation_id => list_all.id )
RoleOperation.create( :role_id => reporter.id, :operation_id => show_all.id )
RoleOperation.create( :role_id => user_manager.id, :operation_id => manage_user.id )

# Create the default admin user
admin = User.create!( :email => 'admin@internal.com', :password => 'abcd1234' )

# Assign admin user with super user role
Permission.create( :role_id => super_user.id, :user_id => admin.id )
