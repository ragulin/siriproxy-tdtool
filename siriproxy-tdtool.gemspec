# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-tdtool"
  s.version     = "0.0.1" 
  s.authors     = ["Mikael Forsberg"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{An Siri Proxy Plugin that wraps tdtool}
  s.description = %q{This is a plugin that wraps tdtool (from http://telldus.com).}


  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "levenshtein-ffi"
end
