require 'spec_helper'

describe Restaurant do 
	before(:all) do
		@restaurant = Restaurant.create(name: "Bob's Big Boy", criticpick: false, link: "http://nymag.com/listings/restaurant/black-pearl/", description: "Fresh, flavorful cuisine with a seasonal bend draws crowds to this Mexican-fusion sleeper in Hell's Kitchen", address: "679 Ninth Ave., at 47th St.", cuisine:"Mexican", price:"$$-$$$", neighborhood:"Hells Kitchen", latitude: 40.7555055, longitude: -73.968065)
	end

	it "is a class" do
		Restaurant.class.should == Class
	end

	it "can be instantiated" do
		@restaurant.class.should == Restaurant
	end

	it "has attributes" do
		@restaurant.name.should == "Bob's Big Boy" 
		@restaurant.criticpick.should == false 
		@restaurant.link.should == "http://nymag.com/listings/restaurant/black-pearl/" 
		@restaurant.description.should == "Fresh, flavorful cuisine with a seasonal bend draws crowds to this Mexican-fusion sleeper in Hell's Kitchen"
		@restaurant.address.should ==  "679 Ninth Ave., at 47th St." 
		@restaurant.cuisine.should == "Mexican" 
		@restaurant.price.should == "$$-$$$" 
		@restaurant.neighborhood.should == "Hells Kitchen" 
		@restaurant.latitude.should ==  40.7555055 
		@restaurant.longitude.should ==  -73.968065
	end

end

