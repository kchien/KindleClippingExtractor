class WritesAnkiImportFile 
  def write_to(file)
    File.open(file, "a") do |f|
      yield f
    end
  end
end
