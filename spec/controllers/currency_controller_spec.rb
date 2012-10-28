describe "CurrencyController" do
 tests CurrencyController

  it "have refresh icon" do
    CurrencyQuerier.mock!(:latest, return: [])
    tap 'Refresh'

    controller.instance_variable_get('@results').should.be.empty
  end
end
