require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#is usable python
describe command("python -h") do
    it { should_not return_stderr /command not found/ }
end
