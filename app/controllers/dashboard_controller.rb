class DashboardController < ApplicationController
  authorize_resource :class => false

  protected
  def get_currents
    []
  end
end
