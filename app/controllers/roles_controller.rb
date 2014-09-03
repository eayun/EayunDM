class RolesController < ApplicationController
  authorize_resource :class => false

  def new
    @role = Role.new
    @roles = Role.all
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
    prepare
    @ret.merge!({:current => get_current, :extra => include_operation_extra})
  end


  def role_params
    params.require(:role).permit(:name, :desc)
  end

  protected
  def secondary_resource?
    false
  end

  def get_currents
    Role.all
  end

  def get_current
    Role.find(params[:id])
  end

  def index_extra
    {:role => Role.new}
  end

  def show_extra
    {:operations => Role.find(params[:id]).operations}
  end

  def include_operation_extra
    {:operations => Operation.all}
  end

  def cur_id_f
    {:id => "id", :name => "name"}
  end
end
