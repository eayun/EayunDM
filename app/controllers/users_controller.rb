class UsersController < ApplicationController
  authorize_resource :class => false

  def index
    @users = User.all
  end


  def new
    @user = User.new
    @users = User.all
  end


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


  def show
    @user = User.find(params[:id])
    @users = User.all
    @permissions = Permission.all.where( :user_id => params[:id] )
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
    @roles = Role.all
    @user = User.find(params[:id])
    @users = User.all
  end


  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation )
  end
end
