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
list_user = Operation.create( :name => 'list all users', :action_name => 'index', :resource_class => 'user' )
show_user = Operation.create( :name => 'show all users', :action_name => 'show', :resource_class => 'user' )
manage_user = Operation.create( :name => 'manage all users', :action_name => 'manage', :resource_class => 'user' )
list_owner = Operation.create( :name => 'list all owners', :action_name => 'index', :resource_class => 'owner' )
show_owner = Operation.create( :name => 'show all owners', :action_name => 'show', :resource_class => 'owner' )
manage_owner = Operation.create( :name => 'manage all owners', :action_name => 'manage', :resource_class => 'owner' )
list_product = Operation.create( :name => 'list all product', :action_name => 'index', :resource_class => 'product' )
show_product = Operation.create( :name => 'show all product', :action_name => 'show', :resource_class => 'product' )
manage_product = Operation.create( :name => 'manage all product', :action_name => 'manage', :resource_class => 'product' )
list_subscription = Operation.create( :name => 'list all subscription', :action_name => 'index', :resource_class => 'subscription' )
show_subscription = Operation.create( :name => 'show all subscription', :action_name => 'show', :resource_class => 'subscription' )
manage_subscription = Operation.create( :name => 'manage all subscription', :action_name => 'manage', :resource_class => 'subscription' )
list_consumer = Operation.create( :name => 'list all consumer', :action_name => 'index', :resource_class => 'consumer' )
show_consumer = Operation.create( :name => 'show all consumer', :action_name => 'show', :resource_class => 'consumer' )
manage_consumer = Operation.create( :name => 'manage all consumer', :action_name => 'manage', :resource_class => 'consumer' )
list_content = Operation.create( :name => 'list all content', :action_name => 'index', :resource_class => 'content' )
show_content = Operation.create( :name => 'show all content', :action_name => 'show', :resource_class => 'content' )
manage_content = Operation.create( :name => 'manage all content', :action_name => 'manage', :resource_class => 'content' )
manage_dash = Operation.create( :name => 'manage all dashboard', :action_name => 'manage', :resource_class => 'dashboard' )

# Create all roles
super_user = Role.create( :name => 'super user', :desc => 'rw everything' )
user_manager = Role.create( :name => 'user manager', :desc => 'manage all users' )
reporter = Role.create( :name => 'reporter', :desc => 'read everything' )
business_manager = Role.create( :name => 'business manager', :desc => 'business manager' )
product_manager = Role.create( :name => 'product manager', :desc => 'product manager' )
technical_support = Role.create( :name => 'technical support', :desc => 'technical support' )

# Create role_operation mapping
RoleOperation.create( :role_id => super_user.id, :operation_id => manage_all.id )
RoleOperation.create( :role_id => reporter.id, :operation_id => list_all.id )
RoleOperation.create( :role_id => reporter.id, :operation_id => show_all.id )
RoleOperation.create( :role_id => user_manager.id, :operation_id => manage_user.id )
RoleOperation.create( :role_id => user_manager.id, :operation_id => manage_dash.id )
RoleOperation.create( :role_id => business_manager.id, :operation_id => manage_owner.id )
RoleOperation.create( :role_id => business_manager.id, :operation_id => manage_subscription.id )
RoleOperation.create( :role_id => business_manager.id, :operation_id => list_product.id )
RoleOperation.create( :role_id => business_manager.id, :operation_id => show_product.id )
RoleOperation.create( :role_id => business_manager.id, :operation_id => manage_dash.id )
RoleOperation.create( :role_id => product_manager.id, :operation_id => manage_product.id )
RoleOperation.create( :role_id => product_manager.id, :operation_id => manage_content.id )
RoleOperation.create( :role_id => product_manager.id, :operation_id => manage_dash.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => manage_consumer.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => list_owner.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => show_owner.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => list_subscription.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => show_subscription.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => list_product.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => show_product.id )
RoleOperation.create( :role_id => technical_support.id, :operation_id => manage_dash.id )

# Create the default admin user
admin = User.create!( :email => 'admin@internal.com', :password => 'abcd1234' )

# Assign admin user with super user role
Permission.create( :role_id => super_user.id, :user_id => admin.id )
