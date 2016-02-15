class Game < ActiveRecord::Base
	attr_accessible :active_player_count, :status, :turn, :winner
	has_many :players, dependent: :destroy
	has_many :oceans, dependent: :destroy # 2 oceans per game one for player one for opponent
end