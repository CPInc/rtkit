# encoding: UTF-8

require File.expand_path('../lib/rtkit/general/version', __FILE__)

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'rtkit'
  s.version = RTKIT::VERSION
  s.date = Time.now
  s.summary = "Library for handling radiotherapy DICOM modalities."
  s.require_paths = ['lib']
  s.author = 'Christoffer Lervag'
  s.email = 'chris.lervag@gmail.com'
  s.homepage = 'https://github.com/dicom/rtkit/'
  s.license = 'GPLv3'
  s.description = "DICOM is a standard widely used throughout the world to store and transfer medical image data. This library enables powerful ways of handling the radiotherapy DICOM modalities in Ruby, to the benefit of any student or professional who would like to go further with their radiotherapy data."
  s.files = Dir["{lib}/**/*", "[A-Z]*"]

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('dicom', '0.9.5')
  s.add_dependency('narray', '0.6.0.8')

  s.add_development_dependency('bundler', '~> 1.5')
  s.add_development_dependency('mocha', '~> 0.14')
  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('redcarpet', '~> 3.0')
  s.add_development_dependency('rspec', '~> 2.14')
  s.add_development_dependency('yard', '~> 0.8.7')
end