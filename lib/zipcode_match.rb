require 'csv'
require 'progressbar'

require 'models/zipcode'

module ActiveRecord
	module Validations
		def self.included(base)
			base.extend ClassMethods
		end
		
		module ClassMethods
			def validates_zipcode_and_city_match(configuration={})
				configuration[:on] ||= :save
				configuration[:city_attr_is] ||= :city # city field
				configuration[:zipcode_attr_is] ||= :zipcode # zipcode field
				 
				send(validation_method(configuration[:on])) do |record|
					zipcode = record.send(configuration[:zipcode_attr_is])
					city = record.send(configuration[:city_attr_is])
					unless ZipcodeMatch::match?(city, zipcode)
						message = configuration[:message] || "Az irányítószám és a település nem egyezik."
						record.errors.add_to_base(message)
					end
				end
			end
			
			def validates_existence_on(city_or_zipcode,configuration={})
				configuration[:on] ||= :save
				
				if city_or_zipcode == :city
					configuration[:attr_is] ||= :city
					configuration[:message] ||= "Ilyen település nem létezik."
				elsif city_or_zipcode == :zipcode
					configuration[:attr_is] ||= :zipcode
					configuration[:message] ||= "Nem létező irányítószám."
				else
					raise ArgumentError, 'Firt argument must be either :city or :zipcode'
				end
				
				send(validation_method(configuration[:on])) do |record|
					attr_value = record.send(configuration[:attr_is])
					unless ZipcodeMatch.send("#{city_or_zipcode}_exist?", attr_value)
						record.errors.add configuration[:attr_is], configuration[:message]
					end
				end
			end
			
		end
		
	end
end

module ZipcodeMatch 
	# Import data from csv files and load it into db.
	# Delete previous records.
	# Use Zipcode an ActiveRecord model.
	def self.import_from_csv
		
		# hash_key for filename.csv
		# hash_value == value of city field in db
		city_names = {
			:budapest => "Budapest",
			:gyor => "Győr",
			:debrecen => "Debrecen",
			:szeged => "Szeged",
			:miskolc => "Miskolc",
			:pecs => "Pécs",
			:telepulesek => nil}
		
		datadir = File.join(File.dirname(__FILE__), 'data')

		self.delete_from_db()
		
		pbar = ProgressBar.new("Importálás", city_names.size)

		city_names.each_pair do |key, city_name|
		
			file_path = File.join(datadir,"#{key}.csv")
						
			csv_reader = CSV::Reader.create(File.open(file_path))
			csv_reader.shift # Shift off first row: column names
			
			if key == :telepulesek
				csv_reader.each do |row|
					Zipcode.create do |z|
						z.zipcode = row[0].to_i
						z.city = row[1].to_s # value in csv file
					end
				end
			else
				csv_reader.each do |row|
					Zipcode.create do |z|
						z.zipcode = row[0].to_i
						z.city = city_name # value in hash
					end
				end
			end
			csv_reader.close
			
			pbar.inc
		end
		
		pbar.finish
	end
	
	def self.delete_from_db
		Zipcode.delete_all
	end
	
	def self.city_exist?(city)
		return !Zipcode.find_by_city(city).nil?
	end
	
	def self.zipcode_exist?(zipcode)
		return !Zipcode.find_by_zipcode(zipcode).nil?
	end
	
	# Checks whether city and zipcode are match with each other.
	# Note: some city has many zipcodes
	def self.match?(city, zipcode)
		Zipcode.find_all_by_city(city).collect(&:zipcode).include?(zipcode)
	end
	
	# Find city for given zipcode
	def self.city_with_zipcode(zipcode)
		zip = Zipcode.find_by_zipcode(zipcode)
		return zip.city unless zip.nil?
		zip
	end
	
	# Find zipcodes 
	# Note: this method is in plural because some city has many zipcodes
	def self.zipcodes_for_city(city)
		zip = Zipcode.find_all_by_city(city)
		return zip.collect(&:zipcode) unless zip.nil?
		zip
	end
end