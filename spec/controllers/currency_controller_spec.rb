describe "CurrencyController" do
 tests CurrencyController

  it "clicking on Refresh" do
    @results = nil
    drag ('Refresh!', from: CGPoint.new(10, 0), to: CGPoint.new(10, 100))

    @results.should.be.nil
  end
end
