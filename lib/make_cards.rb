class MakeCards
  def initialize(file_reader, file_writer)
    @file_reader = file_reader
    @file_writer = file_writer
  end

  def make
    book_highlights = @file_reader.lines

    book_highlights.each do |book_highlight|
      file = file_for_book_title(book_highlight.title)
      @file_writer.write_to(file) do |f|
         f.puts "..."
      end
    end

#    file=File.expand_path(File.join("~/Desktop",
#                            "#{book_highlight.title}.txt"
#                            ))
#    File.open(file, "a") do |f|
#      f.puts "..."
#    end
  end  

  def file_for_book_title(title)
    File.expand_path(File.join("~/Desktop", "#{title}.txt"))
  end
end
