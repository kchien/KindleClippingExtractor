require 'make_cards'
require 'fakefs/spec_helpers'

describe MakeCards do
  include FakeFS::SpecHelpers

  let(:file_reader) { mock }
  let(:file_writer) { mock }
  let(:m) { MakeCards.new( file_reader, file_writer )}

  before { FakeFS::FileSystem.add( File.expand_path"~/Desktop/ForAnkiImport/" ) }

  context "a file with one entry" do

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

    xit "creates one file per book" do  #TODO: make this a cucumber feature (end-to-end)
      m.make
      File.exists?( File.expand_path(File.join("~/Desktop","This is the title of the Book.txt") ) ).should be_true
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
      three_entries = Array.new(3) {entry}
      file_reader.should_receive(:lines).and_return( three_entries )
    end

    it "should call the file_writer 3 times" do        
      file_writer.should_receive(:write_to).exactly(3).times 
      m.make
    end
  end
end
