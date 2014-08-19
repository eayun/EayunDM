require "rest-client"
require "yaml"

class Candlepin < Object

  def initialize(url, user, password)
    @site = RestClient::Resource.new url, user, password
  end

  def execute(method, id, *params)
    if params[-1].class == Hash
      params[-1].merge!({:accept=>:json})
    else
      params[3] = {:accept=>:json}
      params = params.compact
    end
    self.method(method).call(id).call(*params)
  end

  def self.load_resources(file)
    resources = YAML.load_file(file)
    resources.each do |resource, methods|
      methods.each do |method, sub_resources|
        sub_resources.each do |sub_resource|
          r = {:main => resource, :sub => (sub_resource==:self)?nil:sub_resource}
          define_method("#{method}_#{resource_name(r)}") do |id={}|
            @site[self.resource_path(r, id)].method(method)
          end
          private "#{method}_#{resource_name(r)}"
        end if sub_resources.class == Array
      end if methods.class == Hash
    end if resources.class == Hash
  end

  def resource_path(r, id={})
    [r[:main], r[:sub]].zip([id[:id], id[:sub_id]]).flatten.compact.join("/")
  end

  private
  def self.resource_name(r)
    [r[:main], r[:sub]].compact.join("_")
  end

end
