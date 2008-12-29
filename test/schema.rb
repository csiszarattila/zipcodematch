ActiveRecord::Schema.define(:version => 0) do
	create_table :zipcodes, :force => true do |t|
		t.integer :zipcode
		t.string :city
	end
end