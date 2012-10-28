class OpenExchangeClient
  URL = "http://openexchangerates.org/api/latest.json"
  API_KEY = "1971fcc6756e4b7a9cea67478c2a8c09"

  def self.latest(&blk)
    BW::HTTP.get("#{URL}?app_id=#{API_KEY}") do | response | 
      blk.call(response.body.objectFromJSONData['rates'])
    end
  end
end
