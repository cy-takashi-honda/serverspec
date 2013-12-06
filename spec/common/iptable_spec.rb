require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#iptables
describe command('ps aux | grep iptables') do
    begin 
        it { should return_stdout /.+grep\ iptables/ }
    rescue => e
        running_iptable
    end
end

#iptables起動中の場合
def running_iptable

  for port in attributes["enable_ports"] do
    describe port(port) do
      it { should be_listening }
    end
  end

  describe iptables do
    port = nil
    for port in attributes["enable_ports"] do
      it { should have_rule("-A INPUT -m state --state NEW -m tcp -p tcp --dport #{port} -j ACCEPT") }
    end
  end

end