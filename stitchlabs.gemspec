$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stitchlabs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stitchlabs"
  s.version     = Stitchlabs::VERSION
  s.authors     = ["Julio Napurí"]
  s.email       = ["julionc@gmail.com"]
  s.homepage    = "http://www.stitchlabs.com/"
  s.summary     = "MakerShed - Stitch Labs Integration."
  s.description = "MakerShed - Stitch Labs Integration."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
  s.add_dependency "nokogiri", "~> 1.6.7.2"
  s.add_dependency "typhoeus", "~> 1.0.1"
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "webmock"
end
