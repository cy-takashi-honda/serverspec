require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#is usable php
describe command("php -h") do
    it { should_not return_stderr /command not found/ }
end

#PHP version
describe command("php -v") do
    it { should return_stdout /PHP\ #{property["php_ver"]}.+/ }
end
