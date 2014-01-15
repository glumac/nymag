class Restaurant < ActiveRecord::Base

	def combined_location_fields
  		[name, address, "New York"].compact.join(', ')
	end

	geocoded_by :combined_location_fields
end

