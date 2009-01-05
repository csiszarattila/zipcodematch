class ZipcodesGenerator < Rails::Generator::NamedBase
	def manifest
		assigns = {}
		
		record do |m|
			m.migration_template 'migration.rb', "db/migrate", {
				:assigns => assigns,
				:migration_file_name => "create_zipcodes"}
		end
	end
end