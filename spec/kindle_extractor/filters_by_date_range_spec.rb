require 'kindle_extractor/filters_by_date_range'

module KindleExtractor
  RSpec.describe FiltersByDateRange do
    def highlight_added_on(added_on)
      double("highlight", added_on: added_on)
    end

    let(:june_17) { highlight_added_on(DateTime.new(2009, 6, 17, 12, 0, 0)) }
    let(:june_18) { highlight_added_on(DateTime.new(2009, 6, 18, 12, 0, 0)) }
    let(:june_19) { highlight_added_on(DateTime.new(2009, 6, 19, 12, 0, 0)) }
    let(:all)     { [june_17, june_18, june_19] }

    context "with no range given" do
      it "passes every highlight through" do
        expect(described_class.new.select(all)).to eq(all)
      end

      it "does not even look at the timestamps" do
        undated = double("highlight")
        expect(described_class.new.select([undated])).to eq([undated])
      end
    end

    context "with only a from date" do
      it "keeps highlights added on or after it" do
        filter = described_class.new(from: DateTime.new(2009, 6, 18, 0, 0, 0))
        expect(filter.select(all)).to eq([june_18, june_19])
      end
    end

    context "with only a to date" do
      it "keeps highlights added on or before it" do
        filter = described_class.new(to: DateTime.new(2009, 6, 18, 23, 59, 59))
        expect(filter.select(all)).to eq([june_17, june_18])
      end
    end

    context "with both ends of the range" do
      let(:filter) do
        described_class.new(from: DateTime.new(2009, 6, 18, 0, 0, 0),
                            to:   DateTime.new(2009, 6, 18, 23, 59, 59))
      end

      it "keeps only the highlights inside it" do
        expect(filter.select(all)).to eq([june_18])
      end

      it "includes highlights sitting exactly on the boundaries" do
        midnight = highlight_added_on(DateTime.new(2009, 6, 18, 0, 0, 0))
        last_second = highlight_added_on(DateTime.new(2009, 6, 18, 23, 59, 59))
        expect(filter.select([midnight, last_second])).to eq([midnight, last_second])
      end

      it "drops highlights whose date the clippings file did not parse" do
        expect(filter.select([highlight_added_on(nil)])).to eq([])
      end
    end
  end
end
