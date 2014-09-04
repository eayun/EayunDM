require "json"

class ConsumersController < ApplicationController
  authorize_resource :class => false

  def show
    consumer = CANDLEPIN.execute "get_consumers", {:id => params[:id]}
    @consumer = JSON.parse(consumer.to_str)
    respond_to do |format|
      format.js
    end
  end

  protected
  def self.cur_id_f
    {:id => "uuid", :name => "name"}
  end

  def self.pri_id_f
    OwnersController::cur_id_f
  end
end
