require 'minitest/spec'

describe_recipe 'apache2::mod_proxy' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  before :all do
    @prefix = case node[:platform_family]
              when 'rhel'
                node[:apache][:dir]
              when "debian"
                ".."
              end
  end

  it 'enables mod_proxy' do
    link("#{node[:apache][:dir]}/mods-enabled/proxy.load").must_exist.with(
         :link_type, :symbolic).and(:to, "#{@prefix}/mods-available/proxy.load")
  end
end
