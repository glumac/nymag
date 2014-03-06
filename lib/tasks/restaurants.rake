

namespace :restaurantlist do 
	desc "Pull current list of restaurants"
	task :seed => :environment do

		require 'nokogiri'
		require 'open-uri'

    # This scrape searches the first page of New York Magazine Restaurant reviews, the recursively searches each successive result page recursively using the "next" link.  

    Restaurant.destroy_all()
    puts "Restaurants are being seeded. This may take a few moments"


		def pageScrape url
			page = url
			doc = Nokogiri::HTML(open(page))
			nextPage = doc.at_css('.next a')
			doc.css('#resultsFound > tr').each do |item|
				name = item.at_css('dt').text[0, 250]
				if item.at_css('.criticsPick')
					criticpick = true
				else 
					criticpick = false
				end
				link = item.at_css('dt a')[:href]
				desc = item.at_css('.dek')
				if desc
					description = desc.text
				end
				add = item.at_css('.address')
				if add
					add2 = add.text[0, 250]
					address = add2.split(",")[0]
				end
				type = item.at_css('.main').next_element
        cuisinenamearray = type.search('li').map {|li| li.text}
        cuisinecodearray = []
        cuisinenamearray.each do |i|
          case i
          when "Afghani"
            cuisinecodearray.push(1)
          when "African/Moroccan"
            cuisinecodearray.push(2)
          when "American Nouveau"
            cuisinecodearray.push(3)
          when  "American Traditional"
            cuisinecodearray.push(4)
          when "Asian: Southeast"
            cuisinecodearray.push(5)
          when "Australian"
            cuisinecodearray.push(6)
          when "BBQ"
            cuisinecodearray.push(7)
          when "Belgian"
            cuisinecodearray.push(8)
          when "Bistro"
            cuisinecodearray.push(9)
          when "Brazilian"
            cuisinecodearray.push(10)
          when "Cafes"
            cuisinecodearray.push(11)
          when "Cajun/Creole"
            cuisinecodearray.push(12)
          when "Caribbean"
            cuisinecodearray.push(13)
          when "Chinese"
            cuisinecodearray.push(14)
          when "Coffeehouse"
            cuisinecodearray.push(15)
          when "Diner"
            cuisinecodearray.push(16)
          when "Eastern European"
            cuisinecodearray.push(17)
          when "Eclectic/Global"
            cuisinecodearray.push(18)
          when "Extreme Cuisine"
            cuisinecodearray.push(19)
          when "Food Cart"
            cuisinecodearray.push(20)
          when "French"
            cuisinecodearray.push(21)
          when "Gastropub"
            cuisinecodearray.push(22)
          when "German/Austrian"
            cuisinecodearray.push(23)
          when "Greek"
            cuisinecodearray.push(24)
          when "Hamburgers"
            cuisinecodearray.push(25)
          when "Health Food"
            cuisinecodearray.push(26)
          when "Hot Dogs"
            cuisinecodearray.push(27)
          when "Indian"
            cuisinecodearray.push(28)
          when "Irish/English"
            cuisinecodearray.push(29)
          when "Italian"
            cuisinecodearray.push(30)
          when "Japanese/Sushi"
            cuisinecodearray.push(31)
          when "Juice/Smoothie"
            cuisinecodearray.push(32)
          when "Korean"
            cuisinecodearray.push(33)
          when "Latin American"
            cuisinecodearray.push(34)
          when "Mexican"
            cuisinecodearray.push(35)
          when "Middle Eastern"
            cuisinecodearray.push(36)
          when "Molecular Gastronomy"
            cuisinecodearray.push(37)
          when "Pizza"
            cuisinecodearray.push(38)
          when "Portuguese"
            cuisinecodearray.push(39)
          when "Russian"
            cuisinecodearray.push(40)
          when "Scandinavian"
            cuisinecodearray.push(41)
          when "Seafood"
            cuisinecodearray.push(42)
          when "Soup & Sandwich"
            cuisinecodearray.push(43)
          when "South American"
            cuisinecodearray.push(44)
          when "Southern/Soul"
            cuisinecodearray.push(45)
          when "Southwest"
            cuisinecodearray.push(46)
          when "Spanish/Tapas"
            cuisinecodearray.push(47)
          when "Steakhouse"
            cuisinecodearray.push(48)
          when "Thai"
            cuisinecodearray.push(49)
          when "Theme Restaurant"
            cuisinecodearray.push(50)
          when "Turkish"
            cuisinecodearray.push(51)
          when "Vegetarian/Vegan"
            cuisinecodearray.push(52)
          when "Vietnamese"
            cuisinecodearray.push(53)
          else 
            cuisinecodearray.push(0)
          end
        end
        cuisine = "#{[cuisinecodearray].join(', ')}"
			 	priceDiv = type.next_element
			 	if priceDiv
			 		pricetext = priceDiv.text
          if pricetext.include? "$$$-$$$$"
            price = 7
          elsif pricetext.include? "$$$$"
            price = 6
          elsif pricetext.include? "$$-$$$"
            price = 5
          elsif pricetext.include? "$$$"
            price = 4
          elsif pricetext.include? "$$-$"
            price = 3
          elsif pricetext.include? "$$"
            price = 2
          elsif pricetext.include? "$"
            price = 1
          else
            price = 0
          end
        end 
				neighborhoodDiv = priceDiv.next_element
				if neighborhoodDiv
					neighborhood = neighborhoodDiv.text[0, 250]
				end
        # puts name
        # puts criticpick
        # puts link
        # puts description
        puts address
        # puts cuisine
        # puts price
        # puts neighborhood

        # if link != "http://nymag.com/listings/restaurant/the-arepa-lady/index.html"
      	  add_to_database = Restaurant.create(name: name, criticpick: criticpick, link: link, description: description, address: address, cuisine: cuisine, price: price, neighborhood: neighborhood)
        # end
      end
			if nextPage
				pageScrape nextPage[:href]
			end
			
		end

	pageScrape "http://nymag.com/srch?t=restaurant&N=0"

  end
end



