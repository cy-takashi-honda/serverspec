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

describe file('/etc/httpd/conf/httpd.conf') do
    it { should be_file }
    its(:content) {
        should match /Listen\ 80/
        should match /NameVirtualHost\ \*\:80/
        should match /Include\ conf\/virtualhosts\/\*.conf/
    }
end

describe file('/etc/httpd/conf/virtualhosts') do
    it { should be_directory }
end
