class CreatePlaceShips

		ORIENTATION_MAP = { 
			"0" => { x:0, y: -1}, 
			"1" => { x: 1, y: 0}, 
			"2" => { x:0, y: 1}, 
			"3" => { x: -1, y:0}
		}

		def initialize(player:)
			raise ArgumentError.new("player cannot be nil") if player.nil?
    	@ocean = Ocean.find_by(player: player)
    	raise ArgumentError.new("ocean cannot be nil") if @ocean.nil?
		end

		def call
			# Create one of each 
			kinds = Ship::SHIPTYPE_LENGTH_MAP.keys
			for kind in kinds do
				@ship = Ship.new(kind: kind)
				valid_location = false
				@delta = get_rand_delta
				while(!valid_location)
					@first_loc = get_first_location
					valid_location = validate_orientation
				end
				set_ship_locations
				@ship.save
				@ocean.ships << @ship
			end
		end

		private

		def get_rand_delta
			CreatePlaceShips::ORIENTATION_MAP[rand(3).to_s]
		end

		def get_first_location
			x = rand(1..Ocean::X_COUNT)
			y = rand(1..Ocean::Y_COUNT)
			# If location already exists it must be OCCUPPIED by ship
			if @ocean.location_valid(x,y)
				rand_loc = Location.new(x:x, y:y)
			else
				get_first_location
			end
		end

		def validate_orientation
			@ship_length = Ship::SHIPTYPE_LENGTH_MAP[@ship.kind]
			x_end = @first_loc.x + @delta[:x] * (@ship_length - 1)
			y_end = @first_loc.y + @delta[:y] * (@ship_length - 1)
			next_x = @first_loc.x + @delta[:x] * (@ship_length)
			next_y = @first_loc.y + @delta[:y] * (@ship_length)
			if @ocean.location_valid(x_end,y_end) && @ocean.location_valid(next_x,next_y)
				valid = true
				@last_loc = Location.new(x:x_end, y:y_end)
			else
				valid = false
			end
			valid
		end

		def set_ship_locations
			@first_loc.state = Location::LOCATION_STATE_MAP[Location::OCCUPPIED]
			@first_loc.save
			set_location @first_loc
			for i in 1..(@ship_length-2)
				x = @first_loc.x + @delta[:x] * i
				y = @first_loc.y + @delta[:y] * i
				loc = Location.new(x:x, y:y)
				loc.state = Location::LOCATION_STATE_MAP[Location::OCCUPPIED]
				loc.save
				set_location loc
			end
			@last_loc.state = Location::LOCATION_STATE_MAP[Location::OCCUPPIED]
			@last_loc.save
			set_location @last_loc
		end

		def set_location(loc)
			@ship.locations << loc
			@ocean.locations << loc
		end

end