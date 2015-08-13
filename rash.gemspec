# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rash/version"

Gem::Specification.new do |s|
  s.name = %q{rash}
  s.authors = ["tcocca"]
  s.description = %q{simple extension to Hashie::Mash for rubyified keys, all keys are converted to underscore to eliminate horrible camelCasing}
  s.email = %q{tom.cocca@gmail.com}
  s.homepage = %q{http://github.com/tcocca/rash}
  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{simple extension to Hashie::Mash for rubyified keys}

  s.version = Rash::VERSION

  s.add_dependency 'hashie', '~> 3.0'
  s.add_development_dependency 'rake', '~> 0.9'
  s.add_development_dependency 'rdoc', '~> 3.9'
  s.add_development_dependency 'rspec', '~> 2.5'

  s.require_paths = ['lib']
  s.files = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
