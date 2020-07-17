require 'nokogiri'
require 'rspec'
require 'open-uri'

page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))

def get_depute_email(depute_url)
  page = Nokogiri::HTML(URI.open(depute_url))
  depute_url = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  return depute_url
end

def get_first_name(page)
  array_of_first_names = []
  number_of_deputes = page.css('div#deputes-list div ul a').length
  for i in (0..number_of_deputes-1)
    full_name = page.css('div#deputes-list div ul a')[i].text
    first_name = page.css('div#deputes-list div ul a')[i].text.split(" ")[1]
    array_of_first_names << first_name
  end
  return array_of_first_names
end

def get_last_name(page)
  array_of_last_names = []
  number_of_deputes = page.css('div#deputes-list div ul a').length
  for i in (0..number_of_deputes-1)
    full_name = page.css('div#deputes-list div ul a')[i].text
    if full_name.split[2] === "de" || full_name.split[2] === "da"
      last_name = page.css('div#deputes-list div ul a')[i].text.split(" ")[2..full_name.split.length-1].join(" ")
    else
      last_name = page.css('div#deputes-list div ul a')[i].text.split(" ")[2]
    end
    array_of_last_names << last_name
  end
  return array_of_last_names
end

def get_depute_urls(page)
  array_of_urls = []
  number_of_deputes = page.css('div#deputes-list div ul a').length
  for i in (0..number_of_deputes-1)
    depute_url = page.css('div#deputes-list div ul a')[i]['href']
    depute_final_url = "http://www2.assemblee-nationale.fr/" + depute_url[1..depute_url.length-1]
    array_of_urls << depute_final_url
  end
  return array_of_urls
end

def final_array_of_hashes(array_of_urls, page)
  final_array = []
  array_of_urls = get_depute_urls(page)
  number_of_deputes = page.css('div#deputes-list div ul a').length
  for i in (0..number_of_deputes-1)
    email = get_depute_email(array_of_urls[i])
    final_array << {"first_name" => get_first_name(page)[i], "last_name" => get_last_name(page)[i], "email" => email}
    p final_array
  end
  p final_array
end

final_array_of_hashes(get_depute_urls(page), page)
