module DMHelper

# general helper functions
  def make_path(*r)
    r << "path"
    r.join("_")
  end

  def path_caller(path, *params)
    if self.respond_to? path
      self.method(path).call(*params)
    end
  end

# resource name shortcuts

  def r_name_currents
    self.controller_name
  end

  def r_name_current
    r_name_currents.singularize
  end

  def r_name_primaries
    p = PRIMARIES[r_name_currents.to_sym]
    (p.nil?)?nil:(p.to_s)
  end

  def r_name_primary
    (r_name_primaries.nil?)?nil:(r_name_primaries.singularize)
  end

# *_id key shortcuts
  def id_key_current
    r_name_current + "_id"
  end

  def id_key_primary
    r_name_primary.to_s + "_id"
  end

# resource path shortcuts

  def currents_path
    path_caller(make_path(r_name_currents))
  end

  def current_path(id)
    path_caller(make_path(r_name_current), id)
  end

  def primaries_path
    path_caller(make_path(r_name_primaries))
  end

  def primary_path(pid)
    path_caller(make_path(r_name_primary), pid)
  end

  def secondaries_path(pid)
    path_caller(make_path(r_name_primary, r_name_currents), pid)
  end

  def secondary_path(pid, sid)
    path_caller(make_path(r_name_primary, r_name_current), pid, sid)
  end

  def offspring_path(offspring, id)
    path_caller(make_path(r_name_current, offspring), id)
  end

  def pri_offspring_path(offspring, id)
    path_caller(make_path(r_name_primary, offspring), id)
  end
end
