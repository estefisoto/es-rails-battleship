class Ocean < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	belongs_to :game
	belongs_to :player
	has_many :ships, dependent: :destroy

	X_COUNT = Rails.application.config.row_num
	Y_COUNT = Rails.application.config.col_num

	def location_valid(x,y)
		if(x >= 1 && x <= X_COUNT && y>=1 && y <= Y_COUNT)
			self.locations.find_by(x:x,y:y).nil? 		
		else
			false
		end
	end

	def check_for_hit(x,y)
		hit_location = self.locations.find_by(x:x,y:y)
		hit = false
		# If hit location if occupied then change state to hit
		if hit_location 
			if hit_location.is_occuppied?
				hit_location.state = Location::LOCATION_STATE_MAP[Location::HIT]
				hit_location.save
				hit = true
			end
		else
			loc = Location.new(x:x, y:y)
			loc.state == Location::LOCATION_STATE_MAP[Location::MISS]
			loc.save
			self.locations << loc
		end
		hit
	end

	def check_for_sunk(x,y)
		for ship in self.ships
			if !ship.locations.find_by(x:x, y:y).nil?
				sunk = true
				for location in ship.locations
					if location.state != Location::LOCATION_STATE_MAP[Location::HIT]
						sunk = false
						break
					end
				end
				if sunk
					ship.sunk_state = true
					ship.save
				end
				break
			end
		end
		sunk
	end

	def check_for_all_sunk
		if self.ships.where(sunk_state:true).length == Ship::SHIPTYPE_LENGTH_MAP.keys.length
			true
		else
			false
		end
	end

end