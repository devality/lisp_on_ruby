$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Dir["#{Dir.pwd}/lib/**/*.rb"].each {|f| require f}

