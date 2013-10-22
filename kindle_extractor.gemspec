# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'kindle_extractor/version'

Gem::Specification.new do |s|
  s.name = "kindle_extractor"
  s.version = KindleExtractor::VERSION #0.1 #TODO Set to a constant such as KindleExtractor::VERSION
  s.authors = ["Kenrick Chien"]
  s.email = ["ken ドット　chien　アット　gmail　ドット　com"]
  s.homepage = ""
  s.summary = %q{Extracts highlights from Kindle Clippings file, which can be imported into Anki}
  s.description = %q{
        Extracts highlights from Kindle Clippings file, which can be imported into Anki.

        One file per book title is output.
  }

  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*_spec.rb"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "kindleclippings", "~> 1.3.2"

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "fakefs"
  s.add_development_dependency 'rake', "~> 0.9.2.2"
end

