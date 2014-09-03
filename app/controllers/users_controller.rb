class UsersController < ApplicationController
  authorize_resource :class => false

  def create
    User.create!(user_params)

    redirect_to users_url
  end


  def update
    @user = User.find(params[:id])
    if params[:role_id].to_i > 0
      permission = Permission.new
      permission.user_id = params[:id]
      permission.role_id = params[:role_id]
      permission.resource_class = params[:resource_class]
      permission.save
    end

    redirect_to user_url(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end


  def destroy_permission
    permission = Permission.find(params[:permission_id])
    permission.destroy

    redirect_to user_path(User.find(params[:id]))
  end


  def new_permission
    prepare
    @ret.merge!({:current => get_current, :extra => new_permission_extra})
  end


  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation )
  end

  protected
  def secondary_resource?
    false
  end

  def get_currents
    User.all
  end

  def get_current
    User.find(params[:id])
  end

  def index_extra
    {:user => User.new }
  end

  def show_extra
    {:permissions => Permission.all.where( :user_id => params[:id] ) }
  end

  def new_permission_extra
    {:roles => Role.all }
  end

  def cur_id_f
    {:id => "id", :name => "email"}
  end
end
