# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dieter/version"

Gem::Specification.new do |s|
  s.name        = "dieter"
  s.version     = Dieter::VERSION
  s.authors     = ["Walter Smith"]
  s.email       = ["walter@infbio.com"]
  s.homepage    = ""
  s.summary     = %q{Rails localization for Javascript}
  s.description = %q{Javascript i18n library with locale asset generation}

  s.rubyforge_project = "dieter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "i18n"
  s.add_runtime_dependency "sprockets"
end
