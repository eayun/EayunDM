class RolesController < ApplicationController
  authorize_resource :class => false

  def index
    @roles = Role.all
  end


  def new
    @role = Role.new
  end


  def create
    @role = Role.new(role_params)
    @role.save

    redirect_to roles_url
  end


  def edit
    @role = Role.find(params[:id])
  end


  def update
    @role = Role.find(params[:id])
    if params.has_key?(:role)
      @role.update_attributes(role_params)

      redirect_to roles_url
    else
      if params[:operation_id].to_i > 0
        role_operation = RoleOperation.new
        role_operation.role_id = params[:id]
        role_operation.operation_id = params[:operation_id]
        role_operation.save
      end

      redirect_to role_url(@role)
    end
  end


  def show
    @role = Role.find(params[:id])
    @operations = Role.find(params[:id]).operations
  end


  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to roles_url
  end


  def exclude_operation
    role_operation = RoleOperation.where( :operation_id => params[:operation_id], :role_id => params[:id] ).first
    role_operation.destroy

    redirect_to role_path(Role.find(params[:id]))
  end


  def include_operation
    @operations = Operation.all
    @role = Role.find(params[:id])
  end


  def role_params
    params.require(:role).permit(:name, :desc)
  end
end
