require "json"

class ProductsController < ApplicationController
  authorize_resource :class => false

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

  def certificate
    certificate = CANDLEPIN.execute "get_products_certificate", {:id => params[:id]}
    send_data JSON.parse(certificate.to_str)["cert"], :type => "application/text", :filename => "#{params[:id]}.pem"
  end

  protected
  def self.cur_id_f
    {:id => "id", :name => "name"}
  end

  def index_extra
    {:form => DM_FORMS[:new_product]}
  end
end
