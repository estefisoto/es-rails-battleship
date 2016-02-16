class FindOrCreateGame

	def call
		# If a game has oponent pending join that game, else create a new game
	  game = Game.where(active_player_count: 1).first
		if game.nil?
			num_row = Rails.application.config.row_num
      num_col =  Rails.application.config.col_num
			game = Game.create
	  	# Create ocean and locations for player board
	  	player1 = Player.create
	  	player2 = Player.create
	    ocean1 = Ocean.create
	    # for row_i in 1..num_row do
	    #   for col_i in 1..num_col do
	    #     loc = Location.create(x: row_i, y: col_i)
	    #     ocean1.locations << loc
	    #   end
	    # end

	    # Create ocean and locations for opponent player board
	    ocean2 = Ocean.create
	    # for row_i in 1..num_row do
	    #   for col_i in 1..num_col do
	    #     loc = Location.create(x: row_i, y: col_i)
	    #     ocean2.locations << loc
	    #   end
	    # end

	    ocean1.player = player1
	    ocean2.player = player2
	    game.oceans << ocean1
	    game.oceans << ocean2
	    game.players << player1
	    game.players << player2
	  end
	  game
	end

end