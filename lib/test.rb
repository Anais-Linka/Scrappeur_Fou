require 'rubygems'
require 'nokogiri'
require 'open-uri'



  def get_deputy_email(deputy_url)

    deputy_page = Nokogiri::HTML(open(deputy_url))
    email = deputy_page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
    return email
  end


  def get_deputy_full_name(deputy_url)

    deputy_page = Nokogiri::HTML(open(deputy_url))
    deputy_fullname = deputy_page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text

    return deputy_fullname
  end

  def get_deputy_first_and_last_name_email(deputy_url)

    first_name = ""
    last_name = ""

    email = get_deputy_email(deputy_url)
    deputy_fullname = get_deputy_full_name(deputy_url)

    email_firstname = email.split('.')[0]

    email_lastname = email.split('.')[1][0..-21]

    deputy_fullname_nosex = deputy_fullname.delete('Mme ').delete('M.')

    first_name = email_firstname
    last_name = email_lastname

    return first_name, last_name, email
  end


  def get_deputy_url_list(deputylist_url)

    deputylist_page = Nokogiri::HTML(open(deputylist_url))
    deputy_url_list = []

    for n in (1..573)
      url = 'http://www2.assemblee-nationale.fr'+deputylist_page.xpath('//*[@id="DataTables_Table_0"]/tbody/tr['+n+']/td[1]/a').text
      deputy_url_list << url
    end
    return deputy_url_list
  end

deputy_url = 'http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA718894'
puts get_deputy_first_and_last_name_email(deputy_url)

