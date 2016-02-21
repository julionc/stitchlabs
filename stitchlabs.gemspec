# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stitchlabs/version'

Gem::Specification.new do |s|
  s.name        = 'stitchlabs'
  s.version     = Stitchlabs::VERSION
  s.authors     = ['Julio Napurí']
  s.email       = ['julionc@gmail.com']
  s.homepage    = 'http://www.stitchlabs.com/'
  s.summary     = 'MakerShed - Stitch Labs Integration.'
  s.description = 'MakerShed - Stitch Labs Integration.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'rails', '~> 4.2.5.1'
  s.add_dependency 'nokogiri', '~> 1.6.7.2'
  s.add_dependency 'typhoeus', '~> 1.0.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'rubocop'
end
