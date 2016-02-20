module GameHelper

  def get_opponents_ocean(player:)
  	raise ArgumentError.new("player cannot be nil") if player.nil?
  	game = player.game
  	ocean = game.oceans.where.not(player: player).first
  	ocean
  end

  def get_player_from_token(token)
		Player.find_by(token:token)
	end

end