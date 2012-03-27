class WritesAnkiImportFile 
  FIELD_SEPARATOR = "\t"
  def write_out(highlight)
    anki_text_file = "#{highlight.book_title}.txt"     
    File.open(anki_text_file, 'a') do |f|
      front = highlight.content
      back  = "#{highlight.book_title}|#{highlight.author}|#{highlight.location}"

      f.puts "#{front}#{FIELD_SEPARATOR}#{back}"
    end
      #book_title, author, type, location, content
  end
end
