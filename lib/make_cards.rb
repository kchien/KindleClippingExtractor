require 'fileutils'

class MakeCards
  def initialize(file_parser, file_writer)
    @file_parser = file_parser
    @file_writer = file_writer
  end

  def make
    #TODO: make this yield a book_highlight object, similar to and/or using Enumerable#each
    book_highlights = @file_parser.lines 
    book_highlights.each do |highlight|
      @file_writer.write_out(highlight)
    end
  end  

  EXPORT_DIRECTORY = File.expand_path "~/Desktop/ForAnkiImport/"

  def file_for_book_title(title)
    FileUtils.mkdir(EXPORT_DIRECTORY) unless File.exists? EXPORT_DIRECTORY #TODO: refactor!
    File.expand_path(File.join(EXPORT_DIRECTORY, "#{title}.txt"))
  end
end
