require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ZipcodeMatchTest < Test::Unit::TestCase
	
	# Use this instead of setup, 
	# so dont insert test fixtures 
	# before every test method
	private
	def self.insert_fixtures_once
		@zipcodes = []
		@zipcodes << [5200,'Törökszentmiklós']
		@zipcodes << [6000, 'Kecskemét']
		@zipcodes << [6001, 'Kecskemét']
		
		@zipcodes.each do |zipcode|
			Zipcode.create do |z|
				z.zipcode = zipcode[0]
				z.city = zipcode[1]
			end
		end
		
	end
	
	public
  def test_if_match_return_true
		assert ZipcodeMatch::match?("Törökszentmiklós", 5200)
  end

  def test_if_not_match_return_false
		assert !ZipcodeMatch::match?('Törökszentmiklós', 4200)
  end

	def test_city_has_many_zipcode
		assert_equal 2, ZipcodeMatch::zipcodes_for_city('Kecskemét').size
	end
	
	def test_get_back_city_with_zipcode
		assert_equal 'Törökszentmiklós', ZipcodeMatch::city_with_zipcode(5200)
		assert_nil ZipcodeMatch::city_with_zipcode(4200)
	end
	
	def test_city_exist_return_boolean
		assert ZipcodeMatch::city_exist?('Kecskemét')
		assert !ZipcodeMatch::city_exist?('Szolnok')
	end
	
	def test_zipcode_exist_return_boolean
		assert ZipcodeMatch::zipcode_exist?(6000)
		assert !ZipcodeMatch::zipcode_exist?(4200)
	end
end

class Address < ActiveRecord::Base
	validates_zipcode_and_city_match
end

class ZipcodeMatchValidationsTest < Test::Unit::TestCase
	def test_models_validate_states
		address = Address.new do |a|
			a.zipcode = 5200
			a.city = 'Törökszentmiklós'
		end
		assert address.valid?, address.errors.full_messages
		
		address = Address.new do |a|
			a.zipcode = 4500
			a.city = 'Törökszentmiklós'
		end
		assert !address.valid?
		assert_equal 1, address.errors.base.size
	end
	
	def test_accept_attribute_names
		
	end
end
