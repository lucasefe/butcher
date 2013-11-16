# encoding: utf-8

Gem::Specification.new do |s|
  s.name              = "butcher"
  s.version           = "0.0.1"
  s.summary           = ""
  s.description       = ""
  s.authors           = ["Lucas Florio"]
  s.email             = ["lucasefe@gmail.com"]
  s.homepage          = "http://github.com/lucasefe"
  s.files             = []
  s.license           = "MIT"
  # s.executables.push(<executable>)
  s.add_dependency 'curb', '0.8.5'
  s.add_development_dependency 'vcr', '2.7.0'
  s.add_development_dependency 'webmock', '1.15.2'
  s.add_development_dependency 'cuba', '3.1.0'
  s.add_development_dependency 'rspec', '2.14.1'
end
