# -*- encoding: utf-8 -*-
$:.push File.expand_path("lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "kindle_extractor"
  s.version = 0.1 #TODO Set to a constant such as KindleExtractor::VERSION
  s.authors = ["Kenrick Chien"]
  s.email = ["ken.chien@gmail.com"]
  s.homepage = ""
  s.summary = %q{Extracts highlights from Kindle Clippings file, which can be imported into Anki}
  s.description = %q{
        Extracts highlights from Kindle Clippings file, which can be imported into Anki.

        One file per book title is output.
  }

  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*_spec.rb"]
  s.require_paths = ["lib"]
end

