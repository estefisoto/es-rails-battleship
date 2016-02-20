class GameController < ApplicationController
	include GameHelper

	def play
		@player_token = params[:token]
		player = get_player_from_token(@player_token)
		game = player.game
		unless player.is_active?
			player.active = true
			player.save
			game.active_player_count += 1
			if game.turn.nil?
				game.turn = player.id
			end
			game.save
		end
		ocean = Ocean.find_by(player:player)
		@turn = (game.turn == player.id)
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