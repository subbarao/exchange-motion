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

  describe "#archive" do
    before do
      @path = "#{App.documents_path}/tmp.plist"
      manager = NSFileManager.alloc.init
      manager.removeItemAtPath(@path, error:nil)
    end

    it "save to given path" do
      File.exist?(@path).should.be.false
      result = [ Currency.new('USD', 'United States Dollar', 1.0) ]
      CurrencyQuerier.archive(result, 'tmp.plist')

      CurrencyQuerier.current('tmp.plist').should == result
      File.exist?(@path).should.be.true
    end
  end
end
