require 'reads_kindle_clipping_file'

describe ReadsKindleClippingFile do
  describe "#lines" do 
    let(:foo) { stub }
    let(:reader) { described_class.new("foo_filename", foo) }

    context "with an empty file" do 
      it "returns an empty array of book highlights" do 
        foo.should_receive(:open).with("foo_filename", "r").and_yield(foo)
        foo.stub(:gets => nil)
        reader.lines.should == []
      end
    end

    context "with a file with one (1) note/highlight"  do
      let(:lines) do
        [ "==========",
          "This is the title of the Book (Author Name)",
          "- Highlight Loc. 3665-67 | Added on Sunday, February 26, 2012, 02:25 PM",
          "",
          "This is the highlighted text from the book, which fits on one line in this file, regardless of how many sentences where highlighted.  The \"Highlight Loc.\" line above is the approximate place where the highlight was made, and the time that you highlighted it.",
          "==========", 
        nil]
      end

      it "returns an array with one element" do 
        foo.should_receive(:open).with("foo_filename", "r").and_yield(foo) 
        foo.stub(:gets).and_return(*lines)
        reader.lines.size.should == 1
      end
    end
  end
end
