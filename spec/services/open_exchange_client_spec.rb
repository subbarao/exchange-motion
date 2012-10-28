describe "OpenExchangeClient" do
  extend WebStub::SpecHelpers

  before do
    path = "#{App.documents_path}/open.json"
    content = NSString.stringWithContentsOfFile(path, 
                                                encoding:NSUTF8StringEncoding,
                                                error:nil)
    @json = content.objectFromJSONString

    stub_request(:get, OpenExchange::URL).to_return(json: @json)
  end

  it "return rate json" do
    @result = nil

    OpenExchange.latest { | r | @result = r } 

    wait 2.0 do
      @result.should == @json['rate']
    end
  end
end
