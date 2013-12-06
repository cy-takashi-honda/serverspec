class InitSpec

  def InitSpec.get_attr(file)
    filename = file.gsub(/_spec.+/, "")


    split_path = filename.split('/')

    dirname  = split_path[split_path.length - 2]
    filename = split_path[split_path.length - 1]

    self.puts_spec_file(dirname + "/" + filename)

    if property.key?(dirname) && property[dirname].key?(filename) then
      attributes = property[dirname][filename]
    else 
      attributes = nil
    end
    
    return attributes
  end

  def InitSpec.puts_spec_file(filename)
    puts "##########################"
    puts filename
    puts "##########################"
  end

end
