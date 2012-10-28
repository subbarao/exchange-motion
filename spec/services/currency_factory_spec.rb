describe "Currency Factory" do
  before do
    @results = CurrencyFactory.build({ 'INR' => 53.45 , 'EUR' => 0.9 })
  end

  it "instances length" do
    @results.length.should == 2
  end

  it "euro" do
    eur = @results.detect { |r| r.code == 'EUR' }
    eur.rate.should == 0.9
    eur.name.should == "Euro"
  end

  it "indian rupee" do
    inr = @results.detect { |r| r.code == 'INR' }
    inr.rate.should == 53.45
    inr.name.should == "Indian Rupee"
  end
end
