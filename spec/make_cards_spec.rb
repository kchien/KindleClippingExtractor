require 'make_cards'
require 'fakefs/spec_helpers'

describe MakeCards do
  include FakeFS::SpecHelpers

  let(:file_parser) { mock }
  let(:file_writer) { mock }
  let(:m) { MakeCards.new( file_parser, file_writer )}

  before { FakeFS::FileSystem.add( File.expand_path"~/Desktop/ForAnkiImport/" ) }

  context "a file with one entry" do

    before do
      file_parser.should_receive(:lines).and_return( [ stub ])
      file_writer.should_receive(:write_out)
    end

    it "delegates to the file_parser to read the file" do
      m.make
    end

    xit "creates one file per book" do  #TODO: make this a cucumber feature (end-to-end)
      m.make
      File.exists?( File.expand_path(File.join("~/Desktop","This is the title of the Book.txt") ) ).should be_true
    end

  end


  context "a file with 3 entries" do
    let(:entry) { stub }

    before do
      three_entries = Array.new(3) {entry}
      file_parser.should_receive(:lines).and_return( three_entries )
    end

    it "should call the file_writer 3 times" do        
      file_writer.should_receive(:write_out).exactly(3).times 
      m.make
    end
  end
end
