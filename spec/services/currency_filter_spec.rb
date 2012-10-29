describe "CurrencyFilter" do

  describe "#search" do
    before do
      @inr = Currency.new('INR', 'Indian Rupee', 53.344)
      @pkr = Currency.new('PKR', 'Pakistani Rupee', 53.344)
      @eur = Currency.new('EUR', 'Euro', 0.944)

      @filter = CurrencyFilter.new([@inr, @eur, @pkr])
    end

    it "all list sorted by name" do 
      @filter.search.should == [ @eur, @inr, @pkr ]
    end

    it "by name" do 
      @filter.search('Rupee').should == [ @inr, @pkr ]
    end

    it "by code" do 
      @filter.search('PKR').should == [ @pkr ]
    end
  end
end
