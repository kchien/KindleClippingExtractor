require 'parses_kindle_clipping_file'

describe KindleExtractor::ParsesKindleClippingFile do
  describe "#lines" do 
    let(:parser) { stub }
    let(:reader) { described_class.new("foo_filename", parser) }

    context "with an empty file" do 
      it "returns an empty array of book highlights" do 
        clippings = stub(highlights:[])
        parser.should_receive(:parse_file).with("foo_filename").and_return(clippings)
        reader.lines.should == []
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
