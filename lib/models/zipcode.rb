class Zipcode < ActiveRecord::Base
	# Ensure there are only one zipcode and city pair in db
	validates_uniqueness_of :city, :scope => [:zipcode]
end
