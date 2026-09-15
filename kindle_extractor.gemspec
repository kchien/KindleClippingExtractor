# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'kindle_extractor/version'

Gem::Specification.new do |s|
  s.name = "kindle_extractor"
  s.version = KindleExtractor::VERSION
  s.authors = ["Kenrick Chien"]
  s.email = ["ken.chien@gmail.com"]
  s.homepage = "https://github.com/kchien/KindleClippingExtractor"
  s.license = "MIT"
  s.summary = %q{Extracts highlights from Kindle Clippings file, which can be imported into Anki}
  s.description = %q{
        Extracts highlights from Kindle Clippings file, which can be imported into Anki.

        One file per book title is output.
  }

  s.files = Dir["lib/**/*.rb"] + ["README.md", "LICENSE"]
  s.test_files = Dir["spec/**/*_spec.rb"]
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = Dir["exe/*"].map { |f| File.basename(f) }

  s.required_ruby_version = ">= 3.2"

  s.add_runtime_dependency "kindleclippings", "~> 1.4"

  s.add_development_dependency "rspec", "~> 3.13"
  s.add_development_dependency "fakefs", "~> 3.2"
  s.add_development_dependency 'rake', "~> 13.0"
end

