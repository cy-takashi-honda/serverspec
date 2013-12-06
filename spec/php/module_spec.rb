require 'spec_helper'
require 'init_spec'

attributes = InitSpec.get_attr(__FILE__)

#php_modules
describe command("php -i | grep -e \"\/etc\/php.*\/.*\.ini\"") do
    for php_module in attributes["php_modules"] do
        it { should return_stdout /.*#{php_module}\.ini/}
    end
end
