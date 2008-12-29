class ZipcodesGenerator < Rails::Generator::NamedBase
	def manifest
		assigns = {}
		assigns[:migration_action] = "add"
		assigns[:class_name] = "create_zipcodes"
		assigns[:table_name] = "zipcodes"
		assigns[:attributes] = [] 
		assigns[:attributes] << Rails::Generator::GeneratedAttribute.new('zipcode','integer')
		assigns[:attributes] << Rails::Generator::GeneratedAttribute.new('city','string')
		
		record do |m|
			m.migration_template 'migration:migration.rb', "db/migrate", {
				:assigns => assigns,
				:migration_file_name => "create_zipcodes"}
		end
	end
end