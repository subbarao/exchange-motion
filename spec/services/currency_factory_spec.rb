describe "Currency Factory" do
  before do
    content = NSString.stringWithContentsOfFile("#{App.documents_path}/open.json",
                                                encoding:NSUTF8StringEncoding,
                                                error:nil)

    @results = CurrencyFactory.build(content.objectFromJSONString['rates'])
  end

  it "euro" do
    eur = @results.detect { |r| r.code == 'EUR' }
    eur.rate.should == 0.771151
    eur.name.should == "Euro"
  end

  it "indian rupee" do
    inr = @results.detect { |r| r.code == 'INR' }
    inr.rate.should == 53.607928
    inr.name.should == "Indian Rupee"
  end
end
