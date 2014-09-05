class OperationsController < ApplicationController

  def create
    @operation = Operation.new(operation_params)
    @operation.save

    redirect_to operations_url
  end


  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    redirect_to operations_url
  end


  def operation_params
    params.require(:operation).permit(:name, :action_name, :resource_class, :desc)
  end

  protected
  def secondary_resource?
    false
  end

  def get_currents
    Operation.all
  end

  def get_current
    Operation.find(params[:id])
  end

  def index_extra
    {:operation => Operation.new}
  end

  def cur_id_f
    {:id => "id", :name => "name"}
  end
end
