require 'kindleclippings'

module KindleExtractor
  class ParsesKindleClippingFile
  
    def initialize(filename, file_reader=KindleClippings::Parser.new)
      @filename = filename
      @file_reader = file_reader
    end
  
    def lines
      clippings = file_reader.parse_file(filename)
      clippings.highlights
    end
  
    private
    attr_reader :filename, :file_reader
  end
end
