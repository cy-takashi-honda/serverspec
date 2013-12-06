#!/usr/bin/sh
gem install rake
gem install serverspec
gem install inifile

yum -y install ruby-devel
yum -y install make
yum -y install gcc

cd /usr/lib/ruby/gems/1.8/gems/json-1.8.1
gem build json.gemspec
gem install -l json-1.8.1.gem

yum -y install libxml2-devel
yum -y install libxslt-devel

gem install nokogiri -v 1.5.10
gem install aws-sdk

serverspec-init
