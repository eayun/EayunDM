require "json"

class ProductsController < ApplicationController
  def create
    product = [:name, :multiplier].map {|k| [k, params[k]]}.to_h
    product.merge!({:attributes => []})
    CANDLEPIN.execute "post_products", {}, product.to_json, :content_type => :json
    redirect_to products_url
  end

  def destroy
    CANDLEPIN.execute "delete_products", {:id => params[:id]}
    redirect_to products_url
  end

  protected
  def self.cur_id_f
    {:id => "id", :name => "name"}
  end

  def index_extra
    {:form => DM_FORMS[:new_product]}
  end
end
