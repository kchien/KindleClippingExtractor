require 'fileutils'

class MakeCards
  def initialize(file_reader, file_writer)
    @file_reader = file_reader
    @file_writer = file_writer
  end

  def make
    book_highlights = @file_reader.lines  #TODO: make this yield a book_highlight object, similar to and/or using Enumerable#each

    book_highlights.each do |book_highlight|
      file = file_for_book_title(book_highlight.title)

      #TODO: push this code down into the file_writer??
      @file_writer.write_to(file) do |f|
         f.puts "..."
      end
    end

  end  

  EXPORT_DIRECTORY = File.expand_path "~/Desktop/ForAnkiImport/"

  def file_for_book_title(title)
    FileUtils.mkdir(EXPORT_DIRECTORY) unless File.exists? EXPORT_DIRECTORY #TODO: refactor!
    File.expand_path(File.join(EXPORT_DIRECTORY, "#{title}.txt"))
  end
end
