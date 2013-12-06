require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

describe package('httpd') do
    it { should be_installed }
end

describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
end
