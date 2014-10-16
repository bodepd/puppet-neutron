Puppet::Type.newtype(:neutron_service_provider) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from neutron.conf'
    newvalues(/\S+\/\S+/)
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
    munge do |value|
      value = value.to_s.strip
      value
    end
  end

end
