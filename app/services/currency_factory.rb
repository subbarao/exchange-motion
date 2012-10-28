class CurrencyFactory

  Currency = Struct.new(:code, :name, :rate)

  def self.build(json)
    json.map { | code, rate | for_currency(code, rate) }
  end

  private

  def self.for_currency(code, rate)
    Currency.new(code, countries[code.downcase]['name'], rate)
  end

  def self.countries
    @countries ||= begin
                     NSString.stringWithContentsOfFile("#{App.resources_path}/currency.json",
                                                       encoding:NSUTF8StringEncoding,
                                                       error:nil).objectFromJSONString
                   end
  end
end
