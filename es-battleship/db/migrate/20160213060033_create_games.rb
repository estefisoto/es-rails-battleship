class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.integer :active_player_count, default: 1
    	t.integer :status, default: 0
    	t.integer :turn, default: 1
      t.timestamps null: false
    end
  end
end
