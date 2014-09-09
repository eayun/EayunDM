require "yaml"

# Candlepin initialization
EAYUNDM_CONFIG = YAML.load_file("config/candlepin_auth.yml")[Rails.env]
Candlepin.load_resources("config/candlepin_resources.yml")
CANDLEPIN = Candlepin.new EAYUNDM_CONFIG[:baseurl], EAYUNDM_CONFIG[:cp_username], EAYUNDM_CONFIG[:cp_password]

# Web divisions initialization
DIVISIONS = YAML.load_file("config/dm_webdivisions.yml")

PRIMARIES = Hash.new
DIVISIONS.each do |primary, secondaries|
  secondaries.each do |secondary|
    next if primary == secondary
    PRIMARIES[secondary] = primary
  end
end

DIVISIONS_USER = YAML.load_file("config/dm_webdivisions_user.yml")
PRIMARIES_USER = Hash.new
DIVISIONS_USER.each do |primary, secondaries|
  secondaries.each do |secondary|
    next if primary == secondary
    PRIMARIES_USER[secondary] = primary
  end
end

# Content information initialization
CONTENT_INFO = YAML.load_file("config/eayun_contents.yml")

# DM forms initialization
DM_FORMS = YAML.load_file("config/dm_forms.yml")

# DM operation options initialization
DM_OPERATION = YAML.load_file("config/dm_operations.yml")
