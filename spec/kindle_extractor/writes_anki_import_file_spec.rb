require 'kindle_extractor/writes_anki_import_file'
require 'fakefs/safe'
require 'fakefs/spec_helpers'


module KindleExtractor
  describe WritesAnkiImportFile do
    include FakeFS::SpecHelpers
   
    BOOK_TITLE = 'frog'
    let(:writer) { described_class.new }
  
    let(:highlight) { stub(book_title: BOOK_TITLE,
                        content: 'it jumps',
                        author: 'John Doe',
                        location: '- Highlight Loc. 62-63 | Added on Thursday, June 18, 2009, 07:39 PM') }
  
    before do
      FakeFS::FileSystem.add( File.expand_path ENV['PWD'] )
      FakeFS::FileSystem.add( File.expand_path "~/Desktop/" )
    end
  
    describe "how it outputs a highlight as an Anki flashcard" do
      context "given a highlight from a book titled '#{BOOK_TITLE}'" do
        it "writes the highlight to a file named '#{BOOK_TITLE}.txt'" do
           File.should_receive(:open).with(/#{BOOK_TITLE}.txt$/, 'a')
           writer.write_out(highlight)
        end
  
        it "puts the content on the 'front' of the card" do
           file = stub
           File.should_receive(:open).with(/#{BOOK_TITLE}.txt$/, 'a').and_yield(file)
           file.should_receive(:puts).with(/^it jumps/)
           writer.write_out(highlight)
        end
      end
  
      it "accepts an output directory to write files to" do
        writer = WritesAnkiImportFile.new("~/Desktop/to_import_into_anki/")
        writer.write_out(highlight)
        File.exists?( File.expand_path(File.join("~/Desktop/to_import_into_anki","#{BOOK_TITLE}.txt") ) ).should be_true
      end
    end
  end
end
