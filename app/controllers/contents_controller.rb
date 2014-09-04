require "json"

class ContentsController < ApplicationController
  authorize_resource :class => false

  def index
    super
    if secondary_resource?
      render :index_of_product
    end
  end

  def create
    content = [:name, :label, :contentUrl, :type, :vendor].map {|k| [k, params[k]]}.to_h
    CANDLEPIN.execute "post_content", {}, content.to_json, :content_type => :json
    redirect_to contents_url
  end

  def destroy
    CANDLEPIN.execute "delete_content", {:id => params[:id]}
    redirect_to contents_url
  end

  def attach
    CANDLEPIN.execute "post_products_content", {:id => params[:product_id], :sub_id => params[:content]}, {}, :params => {:enabled => "true"}
    redirect_to product_contents_url
  end

  def detach
    CANDLEPIN.execute "delete_products_content", {:id => params[:product_id], :sub_id => params[:id]}
    redirect_to product_contents_url
  end

  protected
  def get_currents
    currents = CANDLEPIN.execute "get_content", {}
    JSON.parse(currents.to_str)
  end

  def get_current
    current = CANDLEPIN.execute "get_content", {:id => params[:id]}
    JSON.parse(current.to_str)
  end

  def self.cur_id_f
    {:id => "id", :name => "name"}
  end

  def self.pri_id_f
    ProductsController::cur_id_f
  end

  def index_extra
    if secondary_resource?
      form = DM_FORMS[:attach_content]
      contents_for_attaching = (@ret[:currents] - @ret[:primary]["productContent"].map {|k| k["content"]}).map {|content| [content["name"], content["id"]]}
      {:form => form.merge({:content => form[:content].merge({:choices => contents_for_attaching})})}
    else
      form = DM_FORMS[:new_content]
      type_for_select = CONTENT_INFO[:type].map {|t| [t, t]}
      vendor_for_select = CONTENT_INFO[:vendor].map {|v| [v, v]}
      {:form => form.merge(
          {:type => form[:type].merge({:choices => type_for_select}),
           :vendor => form[:vendor].merge({:choices => vendor_for_select})
          })}
    end
  end
end
