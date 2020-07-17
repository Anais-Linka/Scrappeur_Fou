require 'rubygems'
require 'nokogiri'
require 'open-uri'
   

def get_townhall_email(townhallurl)
    page = Nokogiri::HTML(open(townhallurl))
     
    return email =page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end 


def get_townhall_urls
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
     
    town_urls = Array.new

    page.xpath('//a[@class="lientxt"]').each do |link|
        town_urls << "http://annuaire-des-mairies.com/" + link["href"].to_s[2..-1]
    end 

    return town_urls
end 


 def get_townhall_names
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
     
    town_names= Array.new

    page.xpath('//a[@class="lientxt"]').each do |link|
        town_names << link.text
    end 
    return town_names
end 


def perform
    
    town_names = get_townhall_names
    town_urls = get_townhall_urls

    list_emails = Array.new

    town_urls.each do |url|
        list_emails << get_townhall_email(url)
    end 
    
    hash = Hash[town_names.zip(list_emails)]
    
    array_of_hashes = Array.new

    hash.each_slice(1).map{|e| e.to_h}.each do |couple|
        array_of_hashes << couple
    end
    return array_of_hashes

end 

puts perform