class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
    	t.string :kind
    	t.belongs_to :ocean, index: true
      t.timestamps null: false
    end
  end
end
