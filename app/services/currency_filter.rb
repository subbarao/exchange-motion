class CurrencyFilter
  def initialize(args = nil)
    @elements = args.sort_by(&:name)
  end

  def search(query_string = nil)
    return @elements if query_string.blank?

    query = Regexp.new(query_string, /i/)
    @elements.select { | r | r.match?(query) }
  end
end
