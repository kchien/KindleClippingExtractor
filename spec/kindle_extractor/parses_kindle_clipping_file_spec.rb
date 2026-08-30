require 'kindle_extractor/parses_kindle_clipping_file'

RSpec.describe KindleExtractor::ParsesKindleClippingFile do
  describe "#lines" do
    let(:parser) { double("file_reader") }
    let(:reader) { described_class.new("foo_filename", parser) }

    context "with an empty file" do
      it "returns an empty array of book highlights" do
        clippings = double("clippings", highlights: [])
        expect(parser).to receive(:parse_file).with("foo_filename").and_return(clippings)
        expect(reader.lines).to eq([])
      end
    end

  end
end
