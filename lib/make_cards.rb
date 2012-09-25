require 'fileutils'

class MakeCards
  def initialize(file_parser, file_writer)
    @file_parser = file_parser
    @file_writer = file_writer
  end

  def make
    book_highlights = @file_parser.lines 
    book_highlights.each do |highlight|
      @file_writer.write_out(highlight)
    end
  end  

end
