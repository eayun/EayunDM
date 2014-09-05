require "json"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  authorize_resource :class => false, :unless => :devise_controller?

  include DMHelper

  rescue_from CanCan::AccessDenied do |exception|
    if not user_signed_in?
      redirect_to :controller => 'users', :action => :sign_in
    else
      throw exception
    end
  end

  def index
    prepare
    @ret.merge!({:extra => index_extra})
  end

  def show
    prepare
    @ret.merge!({:current => get_current, :extra => show_extra})
  end

  protected
  def secondary_resource?
    (not r_name_primaries.nil?) && (not params[id_key_primary].nil?)
  end

  def prepare
    @ret = Hash.new
    if secondary_resource?
      @ret.merge!({:primaries => get_primaries,
                   :primary => get_primary,
                   :primary_id => pri_id_f})
    end
    @ret.merge!({:currents => get_currents, :current_id => cur_id_f})
  end

  def get_primaries
    primaries = CANDLEPIN.execute "get_#{r_name_primaries}", {}
    JSON.parse(primaries.to_str)
  end

  def get_primary
    primary = CANDLEPIN.execute "get_#{r_name_primaries}", {:id => params[id_key_primary]}
    JSON.parse(primary.to_str)
  end

  def self.pri_id_f
  end

  def pri_id_f
    self.class.pri_id_f
  end

  def get_currents
    path = ["get", (secondary_resource?)?(r_name_primaries):nil, r_name_currents].compact.join("_")
    id = (secondary_resource?)?{:id => params[id_key_primary]}:{}
    currents = CANDLEPIN.execute path, id
    JSON.parse(currents.to_str)
  end

  def get_current
    path = ["get", (secondary_resource?)?(r_name_primaries):nil, r_name_currents].compact.join("_")
    id = (secondary_resource?)?{:id => params[id_key_primary], :sub_id => params[:id]}:{:id => params[:id]}
    current = CANDLEPIN.execute path, id
    JSON.parse(current.to_str)
  end

  def self.cur_id_f
  end

  def cur_id_f
    self.class.cur_id_f
  end

  def index_extra
  end

  def show_extra
  end
end
