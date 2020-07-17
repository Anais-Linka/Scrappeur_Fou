require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
puts page.class

def page_acquired?(page)
	class_page = page.class
	if class_page = Nokogiri::HTML::Document
		return "HTML code acquired"
else
		return "Problem occured"
	end
end


 puts page_acquired?(page)

def get_names(page)
    all_names = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')

    names_list = Array.new
        all_names.each do |name|
        names_list << name.text
        end
    return names_list
end

names = get_names(page)

def get_prices(page)
    all_prices = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')

    prices_list = Array.new
        all_prices.each do |price|
        prices_list << price.text
    end
    return prices_list
end


prices = get_prices(page)


final_list = Hash.new
    names.zip(prices){|k,v|final_list[k] = v}
    puts final_list


    
  