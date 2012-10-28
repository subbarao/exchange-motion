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
    ['INR']
  end
end

describe "CurrencyQuerier" do
  it "build currency using the factory" do
    results = CurrencyQuerier.latest(FakeClient, FakeFactory)
    results.should == %w(INR)
  end

  it "cache results" do
    CurrencyQuerier.latest(FakeClient, FakeFactory)
    CurrencyQuerier.latest(FakeClient, FakeFactory)

    FakeClient.counter.should == 1
  end
end
