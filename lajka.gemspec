require File.expand_path("../lib/lajka", __FILE__)

Gem::Specification.new do |s|
  s.name         = "lajka"
  s.version      = Lajka::VERSION
  s.date         = "2015-03-28"
  s.summary      = "Lajka"
  s.description  = "Command-line tool for copying photographs from somewhere to elsewhere"
  s.authors      = ["Jimmy Thelander"]
  s.email        = "jimmy.thelander@gmail.com"
  s.files        = [ "bin/lajka", "lib/lajka.rb" ]
  s.homepage     = "https://github.com/jthelander/lajka"
  s.license      = "MIT"
  s.require_path = "lib"
  s.add_dependency "commander", "~> 4.3"
end
