ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require File.expand_path(File.join(ENV['RAILS_ROOT'],'config/environment.rb'))

begin
	require 'rubygems'
	require 'sqlite3'
rescue MissingSourceFile
	raise "A tesztek futtatásához szükséged lesz az Sqlite3 gemre."
end

ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:dbfile => File.join(File.dirname(__FILE__),'zipcode_match_plugin.sqlite.db')
)

ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__),'debug.log'))

require File.dirname(__FILE__) + '/schema.rb'

zipcodes = []
zipcodes << [5200,'Törökszentmiklós']
zipcodes << [6000, 'Kecskemét']
zipcodes << [6001, 'Kecskemét']

zipcodes.each do |zipcode|
	Zipcode.create do |z|
		z.zipcode = zipcode[0]
		z.city = zipcode[1]
	end
end