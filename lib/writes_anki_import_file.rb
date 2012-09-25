class WritesAnkiImportFile 
  ANKI_FIELD_SEPARATOR = "\t"

  def initialize(dir=ENV['PWD'])
    @output_dir = File.expand_path "#{dir}"
  end

  def write_out(highlight)
    FileUtils.mkdir_p(@output_dir) unless Dir.exists?(@output_dir)

    anki_text_file = File.join(@output_dir, "#{highlight.book_title}.txt")
    File.open(anki_text_file, 'a') do |f|
      front = highlight.content
      back  = "#{highlight.book_title}|#{highlight.author}|#{highlight.location}"

      f.puts "#{front}#{ANKI_FIELD_SEPARATOR}#{back}"
    end
      #book_title, author, type, location, content
  end
end
