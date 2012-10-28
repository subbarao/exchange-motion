class FakeClient
  def self.counter
    @counter
  end

  def self.latest
    @counter ||= 0
    @counter += 1
    yield NSString.stringWithContentsOfFile("#{App.documents_path}/open.json",
                                            encoding:NSUTF8StringEncoding,
                                            error:nil).objectFromJSONString
  end
end

class FakeFactory
  def self.build(json)
    [ Currency.new('USD', 'US Dollar', 1.23) ]
  end
end

describe "CurrencyQuerier" do
  it "build currency using the factory" do
    results = nil 

    CurrencyQuerier.latest(FakeClient, FakeFactory) do | r |
      results = r
    end

    wait 2.0 do
      results.length.should == 1
    end
  end

  it "cache results" do
    CurrencyQuerier.latest(FakeClient, FakeFactory)

    results = nil 

    CurrencyQuerier.latest(FakeClient, FakeFactory) do | r |
      results = r
    end

    FakeClient.counter.should == 1

    wait 2.0 do
      results.length.should == 1
    end
  end

  it "default" do
    @currency = Currency.new('USD', 'US Dollar', 12.23)
    @docs = [ @currency ]
    @path = "#{App.documents_path}/files.plist"
    NSKeyedArchiver.archiveRootObject(@docs, toFile: @path) 

    results = CurrencyQuerier.current(@path)
    results.length.should == 1

    first = results[0]
    first.name.should == "US Dollar"
    first.code.should == "USD"
    first.rate.should == 12.33
  end
end