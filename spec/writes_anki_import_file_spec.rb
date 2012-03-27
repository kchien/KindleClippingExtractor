require 'writes_anki_import_file'

describe WritesAnkiImportFile do
  subject { described_class.new }

  describe "#write_out" do
    context "given a highlight from a book titled 'frog'" do
      let(:highlight) { stub(book_title:'frog',
                            content: 'it jumps',
                            author: 'John Doe',
                            location: '- Highlight Loc. 62-63 | Added on Thursday, June 18, 2009, 07:39 PM') }

      it "writes the highlight to a file named 'frog.txt'" do
         File.should_receive(:open).with('frog.txt', 'a')
         subject.write_out(highlight)
      end

      it "puts the content on the 'front' of the card" do
         file = stub
         File.should_receive(:open).with('frog.txt', 'a').and_yield(file)
         file.should_receive(:puts).with(/^it jumps/)
         subject.write_out(highlight)
      end
    end
  end
end

