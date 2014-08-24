class OperationsController < ApplicationController
  authorize_resource :class => false

  def index
    @operations = Operation.all
  end


  def new
    @operation = Operation.new
    @operations = Operation.all
  end


  def create
    @operation = Operation.new(operation_params)
    @operation.save

    redirect_to operations_url
  end


  def show
    @operation = Operation.find(params[:id])
    @operations = Operation.all
  end


  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    redirect_to operations_url
  end


  def operation_params
    params.require(:operation).permit(:name, :action_name, :resource_class, :desc)
  end
end
