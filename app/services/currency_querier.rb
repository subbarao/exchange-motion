class CurrencyQuerier
  def self.latest(client = OpenExchange, builder = CurrencyFactory)
    @currencies ||= begin
                      client.latest do | r | 
                        @currencies = builder.build(r)
                      end
                    end
  end
end
