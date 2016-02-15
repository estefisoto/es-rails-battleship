class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
    	t.string :token
    	t.belongs_to :game, index: true
      t.timestamps null: false
    end
  end
end
