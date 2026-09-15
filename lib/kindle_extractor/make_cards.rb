require 'fileutils'
require 'kindle_extractor/filters_by_date_range'

module KindleExtractor
  class MakeCards
    def initialize(file_parser, file_writer, date_filter = FiltersByDateRange.new)
      @file_parser = file_parser
      @file_writer = file_writer
      @date_filter = date_filter
    end
  
    def make
      book_highlights = date_filter.select(file_parser.lines)
      book_highlights.each do |highlight|
        file_writer.write_out(highlight)
      end
    end  
  
    private
    attr_reader :file_parser, :file_writer, :date_filter
  end
end
