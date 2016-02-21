class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.integer :x
    	t.integer :y
    	t.integer :state , default: 0 
    	t.belongs_to :ship, index: true
    	t.belongs_to :ocean, index: true
      t.timestamps null: false
    end
  end
end
