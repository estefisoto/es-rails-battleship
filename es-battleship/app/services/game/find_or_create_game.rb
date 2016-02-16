class FindOrCreateGame

	def call
		# If a game has oponent pending join that game, else create a new game
	  game = Game.find_by(active_player_count: 1)
		if game.nil?
			num_row = Rails.application.config.row_num
      num_col =  Rails.application.config.col_num
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