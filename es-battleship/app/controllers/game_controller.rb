class GameController < ApplicationController

	def home

	end

	def play

	end

	def start_game
		game = FindOrCreateGame.new.call
		player1 = game.players.first
		redirect_to play_game_path(player1.token)	
	end

end
