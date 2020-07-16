require_relative '../lib/Dark_trader.rb'

describe "The html code of the Web page" do 

	it "should return the html code of the web page" do
	expect(page_acquired?("https://coinmarketcap.com/all/views/all/")).to eql("HTML code acquired")
	end
end