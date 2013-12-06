require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#is usable awscli
describe command("aws -version") do
    it { should_not return_stderr /command not found/ }
end

#aws credential-file
describe file("/etc/aws/credential-file") do
    it { should be_file }
    attributes.each_value { |v|
  	     it { should contain v }
    }
end
