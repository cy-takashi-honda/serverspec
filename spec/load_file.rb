require 'inifile'

class LoadFile

  def initialize(file)
    @@ini = IniFile.load(file)
  end

  def get(section, name)
    return @@ini[section][name]
  end
end