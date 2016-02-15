class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
    	t.belongs_to :ship, index: true
    	t.belongs_to :player, index: true
      t.timestamps null: false
    end
  end
end
