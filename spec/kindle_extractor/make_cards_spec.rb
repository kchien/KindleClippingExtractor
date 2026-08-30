require 'kindle_extractor/make_cards'
require 'fakefs/spec_helpers'

module KindleExtractor
  RSpec.describe MakeCards do
    include FakeFS::SpecHelpers

    let(:file_parser) { double("file_parser") }
    let(:file_writer) { double("file_writer") }
    let(:m) { MakeCards.new( file_parser, file_writer )}

    before { FakeFS::FileSystem.add( File.expand_path("~/Desktop/ForAnkiImport/") ) }

    context "a file with one entry" do

      before do
        expect(file_parser).to receive(:lines).and_return( [ double("highlight") ] )
        expect(file_writer).to receive(:write_out)
      end

      it "delegates to the file_parser to read the file" do
        m.make
      end

    end

    context "a file with 3 entries" do
      let(:entry) { double("highlight") }

      before do
        three_entries = Array.new(3) { entry }
        expect(file_parser).to receive(:lines).and_return( three_entries )
      end

      it "should call the file_writer 3 times" do
        expect(file_writer).to receive(:write_out).exactly(3).times
        m.make
      end
    end
  end
end
