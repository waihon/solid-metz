require 'yaml'

class Config
  attr_reader :data, :env

  def self.config_path
    File.join('config', 'external_resources')
  end

  def initialize(opts)
    @env = opts[:env] || 'test'
    filename = opts[:filename]
    @data = YAML::load_file(File.join(self.class.config_path, filename))
    define_methods_for_environment(data[@env].keys)
  end

  def define_methods_for_environment(names)
    names.each do |name|
      Config.class_eval <<-EOS
        def #{name}                     # def ftp_host
          data[env]['#{name}']          #   data[env]['ftp_host']
        end                             # end
      EOS
    end
  end
end
