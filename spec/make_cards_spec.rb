require 'make_cards'
require 'fakefs/spec_helpers'

describe MakeCards do
  #include FakeFS::SpecHelpers

  let(:file_reader) { mock }
  let(:file_writer) { mock }
  let(:m) { MakeCards.new( file_reader, file_writer )}

  context "a file with one entry" do
    let(:file) do
    <<-HERE
==========
This is the title of the Book (Author Name)
- Highlight Loc. 3665-67 | Added on Sunday, February 26, 2012, 02:25 PM

This is the highlighted text from the book, which fits on one line in this file, regardless of how many sentences where highlighted.  The "Highlight Loc." line above is the approximate place where the highlight was made, and the time that you highlighted it.
==========
    HERE
    end



    before do
      file_reader.should_receive(:lines).and_return( 
            [
		stub(title: "This is the title of the Book",
		     author: "Author Name",
		     note: "This is the highlighted text from the book",
		     location:" - Highlight Loc. 3665-67 | Added on Sunday, February 26, 2012, 02:25 PM"
		)
            ]
      )

      file_writer.should_receive(:write_to)
    end

    it "delegates to the file_reader to read the file" do
      m.make
    end

    it "creates one file per book" do
      m.make
#Dir.exist?( File.expand_path("~/Desktop") ).should be_true
#      File.exists?( File.expand_path(File.join("~/Desktop","This is the title of the Book.txt") ) ).should be_true
    end

  end


  context "a file with 3 entries" do
    let(:entry) { 
		stub(title: "This is the title of the Book",
		     author: "Author Name",
		     note: "This is the highlighted text from the book",
		     location:" - Highlight Loc. 3665-67 | Added on Sunday, February 26, 2012, 02:25 PM"
		)
    }

    before do
      file_reader.should_receive(:lines).and_return([entry,entry,entry])
    end

    it "should call the file_writer 3 times" do        
      file_writer.should_receive(:write_to).exactly(3).times 
      m.make
    end
  end
end
