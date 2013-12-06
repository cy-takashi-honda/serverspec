class Rds
    def get_host(aws_conf)
        ret = Array.new()
        rds = AWS::RDS.new(
            :access_key_id     => aws_conf["AWSAccessKeyId"],
            :secret_access_key => aws_conf["AWSSecretKey"],
            :rds_endpoint      => aws_conf["endPoint"]
        )

        rds.db_instances.each {|instance|
            if instance.db_instance_identifier.match(/.*#{ENV["hosts"]}.*/) then
                ret.push(instance.endpoint_address)
            end
        }
        return ret
    end
end