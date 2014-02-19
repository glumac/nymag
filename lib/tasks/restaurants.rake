

namespace :restaurantlist do 
	desc "Pull current list of restaurants"
	task :seed => :environment do

		require 'nokogiri'
		require 'open-uri'

	# This scrape searches the first page of New York Magazine Restaurant reviews, the recursively searches each successive result page recursively using the "next" link.  

    Restaurant.destroy_all()
    puts "Restaurants are being seeded. This may take a few moments"


		def pageScrape url

			array = []

			page = url
			doc = Nokogiri::HTML(open(page))
			nextPage = doc.at_css('.next a')
			doc.css('#resultsFound > tr').each do |item|
				name = item.at_css('dt').text[0, 250]
				# if name
				# 	puts name
				# end
				if item.at_css('.criticsPick')
					criticpick = true
				else 
					criticpick = false
				end
				link = item.at_css('dt a')[:href]
				# if link
				# 	puts link
				# end
				desc = item.at_css('.dek')
				if desc
					description = desc.text
				end
				add = item.at_css('.address')
				if add
					add2 = add.text[0, 250]
					address = add2.split("nr.")[0]
				end
				type = item.at_css('.main').next_element
				# cuisinearray = []
				# type.css('li').each do |nomnomnom|
        		  #    	cuisinearray << nomnomnom.text
 #         cuisine = "#{[cuisinearray].join("','")}'"
              cuisine = nil
			 #  	end
			 #  	puts cuisine
			 	priceDiv = type.next_element
			 	if priceDiv
			 		pricetext = priceDiv.text
          # m = /[$-]/.match(pricetext)
          # if m 
          #   price = m.post_match
          # end
          if pricetext
            price = pricetext[0, 250]
          end
        end
				neighborhoodDiv = priceDiv.next_element
				if neighborhoodDiv
					neighborhood = neighborhoodDiv.text[0, 250]
				end
				# array << "#{name}, #{criticpick}, #{link}, #{description}, #{address}, #{cuisine}, #{price}, #{neighborhood}"
				# puts array
        puts name
        puts criticpick
        puts link
        puts description
        puts address
        puts cuisine
        puts price
        puts neighborhood

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



