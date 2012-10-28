describe "OpenExchangeClient" do
  extend WebStub::SpecHelpers

  before do
    content = NSString.stringWithContentsOfFile("#{App.documents_path}/open.json",
                                                encoding:NSUTF8StringEncoding,
                                                error:nil)
    @json = content.objectFromJSONString

    stub_request(:get, "#{OpenExchangeClient::URL}?app_id=#{OpenExchangeClient::API_KEY}").
      to_return(json: @json)
  end

  it "return rate json" do
    @result = nil

    OpenExchangeClient.latest { | r | @result = r } 

    wait 2.0 do
      @result.should == @json['rates']
    end
  end
end
