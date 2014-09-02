require "json"

class SubscriptionsController < ApplicationController
  def create
    subscription = [:quantity, :startDate, :endDate, :contractNumber].map {|k| [k, params[k]]}.to_h
    subscription.merge!({:product => {:id => params[:product]}})
    CANDLEPIN.execute "post_owners_subscriptions", {:id => params[:owner_id]}, subscription.to_json, :content_type => :json
    CANDLEPIN.execute "put_owners_subscriptions", {:id => params[:owner_id]}, "", :content_type => :json
    redirect_to owner_subscriptions_url
  end

  def destroy
    CANDLEPIN.execute "delete_subscriptions", {:id => params[:id]}
    redirect_to owner_subscriptions_url
  end

  protected
  def self.cur_id_f
    {:id => "id", :name => nil}
  end

  def self.pri_id_f
    OwnersController::cur_id_f
  end

  def index_extra
    products = CANDLEPIN.execute "get_products", {}
    products_for_select = JSON.parse(products.to_str).map {|product| [product["name"], product["id"]]}
    form = DM_FORMS[:new_subscription]
    {:form => form.merge({:product => form[:product].merge({:choices => products_for_select})})}
  end
end
