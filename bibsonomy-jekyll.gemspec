# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'bibsonomy-jekyll'
  s.summary     = 'BibSonomy plugin for Jekyll'
  s.version     = BibSonomy::VERSION
  s.authors     = ['Robert Jäschke']
  s.email       = 'jaeschke@l3s.de'
  s.description = %q{Enables rendering of posts from BibSonomy with a Jekyll tag.}
    
  s.homepage = 'https://github.com/rjoberon/bibsonomy-jekyll'
  s.licenses = ['GPL 3']
  s.files    = [ 'lib/bibsonomy-jekyll.rb' ]

  s.add_dependency 'jekyll', '~> 3.0'
  s.add_dependency 'bibsonomy', '~> 0.4', '>= 0.4.8'

  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rdoc', '~> 0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
