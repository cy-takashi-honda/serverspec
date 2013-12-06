class Util
    def Util.chk_key(key, val)
        if !val.key?(key) then
            puts "#### ERROR ####"
            puts "No #{key} @#{val}"
            puts "###############"
            exit
        end
    end

    def Util.chk_length(arr)
        if arr.length <= 0 then
            puts "#### ERROR ####"
            puts "No #{arr}"
            puts "###############"
            exit
        end
    end

    def Util.get_aws_instance(type)
        self.require_all(File.dirname(__FILE__) + "/aws/*.rb")
        ret = nil
        if type == "ec2" then
            ret = Ec2.new()
        elsif type == "rds" then
            ret = Rds.new()
        else
            puts "#### ERROR ####"
            puts "No type"
            puts "###############"
            exit
        end

        return ret
    end

    def Util.require_all(path)
        Dir[path].each {|file| 
            require file
        }
    end
end
