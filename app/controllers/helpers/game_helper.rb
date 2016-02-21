module GameHelper

  def get_player_from_token(token)
		Player.find_by(token:token)
	end

	def get_opponent_player(player:)
	  raise ArgumentError.new("player cannot be nil") if player.nil?
	  game = player.game
		player = game.players.where.not(id:player.id).first
		player 
	end

	def set_player_turn(player:)
	  raise ArgumentError.new("player cannot be nil") if player.nil?
	  game = player.game
	  game.turn = player.id
	  game.save
	end 

end