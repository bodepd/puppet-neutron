# I could not, for the life of me, figure out how to programatcally set the modulepath
$LOAD_PATH.push(
  File.join(
    File.dirname(__FILE__),
    '..',
    '..',
    '..',
    'fixtures',
    'modules',
    'inifile',
    'lib')
)
require 'spec_helper'
provider_class = Puppet::Type.type(:neutron_service_provider).provider(:ini_setting)
describe provider_class do

  it 'should create a service_provider entry' do
    resource = Puppet::Type::Neutron_service_provider.new(
      {:name => 'LOADBALANCER/Haproxy', :value => 'neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default'}
    )
    provider = provider_class.new(resource)
    provider.section.should == 'service_providers'
    provider.setting.should == 'service_provider=LOADBALANCER:Haproxy'
    provider.value.should == 'neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default'
  end

end
