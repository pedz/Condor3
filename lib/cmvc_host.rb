#
# A class to help issue CMVC commands from a particular host.  It will
# be configured by the cmvc.yml file in the config directory (which
# will be loaded by an initializer).
class CmvcHost
  Config = YAML.load(File.open("#{RAILS_ROOT}/config/cmvc.yml"))
end
