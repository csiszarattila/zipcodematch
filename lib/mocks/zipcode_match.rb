module ZipcodeMatch
	def self.match?(city,address)
		return true
	end
	
	def self.city_exist?(city)
		return true
	end
	
	def self.zipcode_exist?(zipcode)
		return true
	end
	
	def self.match?(city, zipcode)
		return true
	end
	
	def self.city_with_zipcode(zipcode)
		""
	end
	
	def self.zipcodes_for_city(city)
		[1000,1001,1002]
	end
end