require 'date'

module KindleExtractor
  class FiltersByDateRange
    def initialize(from: nil, to: nil)
      @from = from
      @to = to
    end

    def select(highlights)
      return highlights unless from || to

      highlights.select { |highlight| in_range?(highlight.added_on) }
    end

    private
    attr_reader :from, :to

    def in_range?(added_on)
      return false if added_on.nil?
      return false if from && added_on < from
      return false if to && added_on > to

      true
    end
  end
end
