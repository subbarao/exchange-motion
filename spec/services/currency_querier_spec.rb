class FakeClient
  def self.latest
    yield([])
  end
end

class FakeFactory
  def self.build(json)
    %w(results)
  end
end

describe "CurrencyQuerier" do

  describe "#latest" do
    it "executes block" do 
      @called = false

      CurrencyQuerier.latest(FakeClient, FakeFactory) do 
        @called = true
      end

      @called.should.be.true
    end

    it "with builder results" do 
      @results = nil

      CurrencyQuerier.latest(FakeClient, FakeFactory) do | r | 
        @results = r
      end

      @results.should == %w(results)
    end
  end

=begin
  describe "#current" do
    it "must read data from the archived file" do
      NSKeyedUnarchiver.should.receive(:unarchiveObjectWithFile).with('test.plist').and_return([])
    end
  end

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
=end
end
