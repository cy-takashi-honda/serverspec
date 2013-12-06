require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#selinux
describe selinux do
    begin
        it { should be_disabled }
    rescue => e
        it { should be_permissive }
    end
end

#sshd
describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
end

#ntpd
describe service('ntpd') do
    it { should be_enabled }
    it { should be_running }
end

#git
describe package('git') do
    it { should be_installed }
end
