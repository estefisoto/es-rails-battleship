class FindOrCreateGame

	def call
		# If a game has oponent pending join that game, else create a new game
	  games = Game.where(active_player_count:0..1)
		if games.length > 0
			game = games.first
	  else
	  	game = Game.create
	  	
	  	player1 = Player.create
	  	player2 = Player.create
	  	# Create ocean and locations for player board
	    ocean1 = Ocean.create
	    # Create ocean and locations for opponent player board
	    ocean2 = Ocean.create

	    ocean1.player = player1
	    ocean2.player = player2
	    game.oceans << ocean1
	    game.oceans << ocean2
	    game.players << player1
	    game.players << player2

	    CreatePlaceShips.new(player:player1).call
	    CreatePlaceShips.new(player:player2).call
	  end
	  game
	end

end