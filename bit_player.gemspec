# frozen_string_literal: true
$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bit_player/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bit_player"
  s.version     = BitPlayer::VERSION
  s.authors     = ["Eric Carty-Fickes"]
  s.email       = ["ericcf@northwestern.edu"]
  s.homepage    = "https://github.com/NU-CBITS/bit_player"
  s.summary     = "A Rails engine for presenting a BIT web application"
  s.description = "A Rails engine for presenting a BIT web application"

  s.files = Dir["{app,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "pg", "~> 0.17"
  s.add_development_dependency "spring"
  s.add_development_dependency "rspec-rails", "~> 3.5.0.beta3"
  s.add_development_dependency "rubocop", "~> 0.25"
  s.add_development_dependency "brakeman"
end
