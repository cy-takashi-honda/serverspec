require 'serverspec'
require 'pathname'
require 'net/ssh'

#add
require 'json'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

open (ENV["CONFIG_PATH"]) do |io|
    config_json = JSON.load(io)
    if ENV["hosts"] == "localhost" then
        @config = config_json[ENV["target"]]["config"]["localhost"]
    else
        @config = config_json[ENV["target"]]["config"]["default"]
    end
end

open(ENV["JSON_PATH"]) do |io|
    @json = JSON.load(io)
end


RSpec.configure do |c|

    c.sudo_password = @config["sudo_password"]
    c.host  = ENV['TARGET_HOST']
    puts "##########################"
    puts "#{c.host}"
    puts "##########################"
    options = Net::SSH::Config.for(c.host)

    if !options.key?('keys') then
        options[:keys] = @config["IdentityFile"]
    end

    user = options[:user] || @config["user"]

    begin
        c.ssh   = Net::SSH.start(c.host, user, options)
        c.os    = backend(Serverspec::Commands::Base).check_os
        set_property @json
    rescue => e
        puts "SSH Auth failed"
        puts e.message
        exit
    end

end

