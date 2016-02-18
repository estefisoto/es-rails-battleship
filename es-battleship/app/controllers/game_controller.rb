class GameController < ApplicationController

	def home

	end

	def play
		player = current_player(params[:token])
		ocean = Ocean.find_by(player:player)
		@row_count = Ocean::X_COUNT
		@col_count = Ocean::Y_COUNT
		@locations = LocationDecorator.decorate_collection(ocean.locations).as_json
	end

	def start_game
		game = FindOrCreateGame.new.call
		player1 = game.players.first
		redirect_to play_game_path(player1.token)	
	end

	private 

	def current_player(token)
		Player.find_by(token:token)
	end
end
