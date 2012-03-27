require 'rubygems'
require './lib/make_cards'
require './lib/parses_kindle_clipping_file'
require './lib/writes_anki_import_file'

#TODO: make a command-line friendly version
file = ARGV[0]
card_maker = MakeCards.new( ParsesKindleClippingFile.new(file), WritesAnkiImportFile.new)
card_maker.make
