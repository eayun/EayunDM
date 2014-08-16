class OperationsController < ApplicationController
  def index
    @operations = Operation.all
  end


  def new
    @operation = Operation.new
  end


  def create
    @operation = Operation.new(operation_params)
    @operation.save

    redirect_to operations_url
  end


  def edit
    @operation = Operation.find(params[:id])
  end


  def update
    @operation = Operation.find(params[:id])
    @operation.update_attributes(operation_params)

    redirect_to operations_url
  end


  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    redirect_to operations_url
  end


  def operation_params
    params.require(:operation).permit(:name, :desc)
  end
end
