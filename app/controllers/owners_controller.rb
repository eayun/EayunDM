require "json"
require "digest/sha1"

class OwnersController < ApplicationController

  def create
    owner = [:key, :displayName, :contentPrefix].map {|k| [k, params[k]]}.to_h
    CANDLEPIN.execute "post_owners", {}, owner.to_json, :content_type => :json

    password = Digest::SHA1.hexdigest(EAYUNDM_CONFIG[:cp_user_pwd_salt] + params[:password])
    user = {:username => params[:key],
            :hashedPassword => password,
            :superAdmin => false}
    CANDLEPIN.execute "post_users", {}, user.to_json, :content_type => :json

    role = {:name => params[:key]}
    newrole = CANDLEPIN.execute "post_roles", {}, role.to_json, :content_type => :json
    newrole_id = JSON.parse(newrole.to_str)["id"]
    CANDLEPIN.execute "post_roles_users", {:id => newrole_id, :sub_id => params[:key]}, "", :content_type => :json

    permission = {:owner => params[:key], :type => "OWNER", :access => "ALL"}
    CANDLEPIN.execute "post_roles_permissions", {:id => newrole_id}, permission.to_json, :content_type => :json

    redirect_to owners_url
  end

  def destroy
    roles = CANDLEPIN.execute "get_users_roles", {:id => params[:id]}
    JSON.parse(roles.to_str).each do |role|
      CANDLEPIN.execute "delete_roles", {:id => role["id"]}
    end
    CANDLEPIN.execute "delete_users", {:id => params[:id]}
    CANDLEPIN.execute "delete_owners", {:id => params[:id]}
    redirect_to owners_url
  end

  protected
  def self.cur_id_f
    {:id => "key", :name => "displayName"}
  end

  def index_extra
    {:form => DM_FORMS[:new_owner]}
  end
end
