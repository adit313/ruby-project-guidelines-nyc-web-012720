class CreateRounds < ActiveRecord::Migration[5.2]
  def change
  		create_table :rounds do |t|
		t.string :object
		t.boolean :won
		t.integer :user_id
	end
  end
end
