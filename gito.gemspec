# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','gito','version.rb'])
spec = Gem::Specification.new do |s|
  s.name            = 'gito'
  s.version         = Gito::VERSION
  s.authors         = ['cesar ferreira']
  s.email           = ['cesar.manuel.ferreira@gmail.com']
  s.homepage        = 'https://github.com/cesarferreira/gito'
  s.license         = 'MIT'
  s.platform        = Gem::Platform::RUBY
  s.summary         = 'git helper tool to clone/open/install/edit a git project with a one-liner'
  s.files           = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.required_ruby_version = '>= 2.0.0'

  s.bindir = 'bin'
  s.executables << 'gito'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'pry-byebug', '~> 3.2'
  s.add_development_dependency 'rspec'

  s.add_dependency 'bundler', '~> 1.7'
  s.add_dependency 'colorize', '~> 0.7'
end
