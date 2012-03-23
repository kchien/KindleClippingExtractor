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
        [ "This is the title of the Book (Author Name)\n",
          "- Highlight Loc. 3665-67 | Added on Sunday, February 26, 2012, 02:25 PM\n",
          "\n",
          "This is the highlighted text from the book, which fits on one line in this file, regardless of how many sentences where highlighted.  The \"Highlight Loc.\" line above is the approximate place where the highlight was made, and the time that you highlighted it.\n",
          "==========", 
        nil]
      end

      it "returns an array with one element" do 
        foo.should_receive(:open).with("foo_filename", "r").and_yield(foo) 
        foo.stub(:gets).and_return(*lines)
        reader.lines.size.should == 1
      end

      it "should parse the note correctly" do
        foo.should_receive(:open).with("foo_filename", "r").and_yield(foo) 
        foo.stub(:gets).and_return(*lines)
        kindle_note = reader.lines[0]
        
        kindle_note.title.should =~ /This is the title of the Book/
        kindle_note.location.should =~ /Highlight Loc. 3665-67/
      end
    end
  end
end

__END__
Kindle DX User's Guide (Amazon.com)
- Note Loc. 165 | Added on Thursday, June 18, 2009, 04:57 PM

this is just a test. delete me later.
==========
completeguide.html (foobar@foo.com)
- Bookmark Loc. 63 | Added on Thursday, June 18, 2009, 07:39 PM


==========
completeguide.html (foobar@foo.com)
- Highlight Loc. 62-63 | Added on Thursday, June 18, 2009, 07:39 PM

Therefore, even if you don't get something completely the first time right away, just move on and keep referring back as you see more examples.
==========
