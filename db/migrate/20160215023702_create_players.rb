class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
    	t.string :token
    	t.boolean :active, default:false
    	t.belongs_to :game, index: true
      t.timestamps null: false
    end
  end
end
