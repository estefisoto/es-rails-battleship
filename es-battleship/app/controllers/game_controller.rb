class GameController < ApplicationController

	def home

	end

	def play
		player = current_player(params[:token])

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
