$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bit_player/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bit_player"
  s.version     = BitPlayer::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BitPlayer."
  s.description = "TODO: Description of BitPlayer."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.3"

  s.add_development_dependency "pg"
end
