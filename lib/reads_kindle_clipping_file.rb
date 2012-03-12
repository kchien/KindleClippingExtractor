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
      while ( line = f.gets ) do
        if (line =~ /^={6}/ )
          (line=f.gets).nil?  ? next : b.title=line.strip 
          (line=f.gets).nil?  ? next : b.location=line.strip
          (line=f.gets).nil?  ? next : b.note=line.strip

          book_info << b
        end
      end
    end
    book_info
  end
end
