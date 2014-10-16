Puppet::Type.type(:neutron_service_provider).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

  def exists?
    keyval_regex = /^#{setting}#{separator}#{value}$/
    File.open(file_path, "r") do |infile|
      while (line = infile.gets)
        if keyval_regex.match(line)
          return true
        end
      end
    end
    false
  end

  def create
    ini_file.set_value(section, setting, value)
    ini_file.save
    @ini_file = nil
  end

  def section
    'service_providers'
  end

  def setting
    'service_provider=' + resource[:name].split('/',2).join(':')
  end

  def value
    resource[:value]
  end

  def value=(value)
    ini_file.set_value(section, setting, value)
    ini_file.save
  end

  def file_path
    '/etc/neutron/neutron.conf'
  end

  def separator
    ':'
  end

  private
  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(file_path, separator)
  end

end
