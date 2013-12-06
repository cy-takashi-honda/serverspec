class Ec2
    def get_host(aws_conf)
        ret = Array.new()
        ec2 = AWS::EC2.new(
            :access_key_id     => aws_conf["AWSAccessKeyId"],
            :secret_access_key => aws_conf["AWSSecretKey"],
            :ec2_endpoint      => aws_conf["endPoint"]
        )

        ec2.instances.each {|instance|
            instance.tags.each {|tag|
                if tag[0] == "Name" && tag[1].match(/.*#{ENV["hosts"]}.*/) then
                    ret.push(instance.dns_name)
                end
            }
        }

        return ret
    end
end
