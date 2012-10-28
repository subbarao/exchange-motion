class CurrencyFactory

  def self.build(json)
    json.map { | code, rate | for_currency(code, rate) }.compact
  end

  private

  def self.for_currency(code, rate)
    if codeData = countries[code.downcase]
      Currency.new(code, codeData['name'], rate)
    end
  end

  def self.countries
    @countries ||= begin
                     NSString.stringWithContentsOfFile("#{App.resources_path}/currency.json",
                                                       encoding:NSUTF8StringEncoding,
                                                       error:nil).objectFromJSONString
                   end
  end
end
