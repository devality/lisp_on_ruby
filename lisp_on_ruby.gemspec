# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lisp_on_ruby/version'

Gem::Specification.new do |spec|
  spec.name        = 'lisp_on_ruby'
  spec.version     = LispOnRuby::VERSION
  spec.date        = '2017-10-30'
  spec.summary     = "Lisp interpreter written on ruby"
  spec.description = ""
  spec.authors     = ["Aleksandr Nikishin"]
  spec.email       = ['azmesmparser@gmail.com']
  spec.executables << 'lisp_on_ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'byebug'
end
