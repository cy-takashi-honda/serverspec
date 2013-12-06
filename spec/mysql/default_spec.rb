require 'spec_helper'

describe 'mysqld' do
    it { should be_enabled }
    it { should be_running }
end

describe "port #{property[:listen_port]}" do
    it { should be_listening }
end
