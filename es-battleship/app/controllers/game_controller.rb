class GameController < ApplicationController
	include GameHelper

	def home

	end

	def play
		@player_token = params[:token]
		player = get_player_from_token(@player_token)
		ocean = Ocean.find_by(player:player)
		@row_count = Ocean::X_COUNT
		@col_count = Ocean::Y_COUNT
		@locations = LocationDecorator.decorate_collection(ocean.locations).as_json
	end

	def start_game
		game = FindOrCreateGame.new.call
		player = game.players.where(active:false).first
		redirect_to play_game_path(player.token)	
	end

end