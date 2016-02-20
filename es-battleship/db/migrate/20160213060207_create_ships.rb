class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
    	t.string :kind
    	t.boolean :sunk_state, default: false
    	t.belongs_to :ocean, index: true
      t.timestamps null: false
    end
  end
end
