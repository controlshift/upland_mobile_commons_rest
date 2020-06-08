def fixture(name)
  File.read(File.join(File.dirname(__FILE__), '..','fixtures', name))
end
