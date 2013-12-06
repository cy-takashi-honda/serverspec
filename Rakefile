require 'rake'
require 'rspec/core/rake_task'
require 'serverspec'

require 'json'
require 'aws-sdk'
require 'util'

desc "Run serverspec to all hosts"
task :serverspec => 'serverspec:all'

Util.chk_key("target", ENV)
Util.chk_key("role", ENV)
Util.chk_key("hosts", ENV)
# Util.chk_key("aws", ENV)

@hosts   = Array.new()
TARGET   = ENV["target"]
ROLE     = ENV["role"]

if ENV.key?("aws") then
    AWS_TYPE = ENV["aws"]
else
    AWS_TYPE = nil
end

open(File.dirname(__FILE__) + "/attr.json") do |io|
    @json = JSON.load(io)
end

Util.chk_key(TARGET, @json)
Util.chk_key(ROLE, @json[TARGET]["roles"])


#hosts以下にENV["hosts"]で指定されたJSONファイルが存在するとき
if File.exist?(File.dirname(__FILE__) + "/hosts/#{TARGET}/#{ENV["hosts"]}.json") then
    open(File.dirname(__FILE__) + "/hosts/#{TARGET}/#{ENV["hosts"]}.json") do |io|
        @hosts = JSON.load(io)
    end

else

    aws_conf = Hash.new
    open(@json[TARGET]["aws_conf"],"r:utf-8").each_line do |line|
        next if line.empty? or line =~ /^#|^$/
            key,value = line.split(/=/,2)
        aws_conf[key.strip] = value.strip
    end

    aws_conf["endPoint"] = @json[TARGET]["end_points"][AWS_TYPE]

    ins = Util::get_aws_instance(AWS_TYPE)

    @hosts = ins.get_host(aws_conf)

end

Util.chk_length(@hosts)

namespace :serverspec do
    roles = @json[TARGET]["roles"][ROLE]

    ENV["CONFIG_PATH"] = File.dirname(__FILE__) + "/attr.json"
    ENV["JSON_PATH"]   = File.dirname(__FILE__) + "/targets/" + TARGET + "/" + ROLE + ".json"

    task :all => @hosts.map { |h| 'serverspec:' + h }

    @hosts.each do |host|
        desc "Run serverspec to #{host}"
        RSpec::Core::RakeTask.new(host) do |t|
            ENV["TARGET_HOST"] = host
            patterns = Array.new()
            for role in roles do
                #default以外のテスト
                if role.match(/.+\/.+/) then
                    patterns.push('spec/' + role + '_spec.rb')
                else 
                    patterns.push('spec/' + role + '/default_spec.rb')
                end
            end
            t.pattern = patterns
        end
    end
end
