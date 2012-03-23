class ReadsKindleClippingFile
  BookNote = Struct.new(:title, :author, :note, :location)

  def initialize(filename, file_reader)
    @filename = filename
    @file_reader = file_reader
  end
  
  def lines
    book_info = []

    @file_reader.open(@filename, "r") do |f|
      b = BookNote.new
      while ( line=next_blank_line_from_file(f) ) do
           b.title = line
#           puts "just set title: #{b.title}"
           
          b.location = line=next_blank_line_from_file(f)
#          puts "just set loc: #{b.location}"

          f.gets.strip #blank line??

          b.note = line=next_blank_line_from_file(f)
#          puts "just set note: #{b.note}"

          line=f.gets.strip
#          puts "just read #{line}"
          book_info << b if line =~ /^={6}/
      end
    end
    book_info
  end

  def next_blank_line_from_file(f) 
    line = f.gets 
    line.nil? ? nil : line.strip
  end
end
