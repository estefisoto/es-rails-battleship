class Ocean < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	belongs_to :game
	belongs_to :player
	has_many :ships, dependent: :destroy

	X_COUNT = Rails.application.config.row_num
	Y_COUNT = Rails.application.config.col_num

	def location_valid(x,y)
		if(x >= 1 && x <= X_MAX && y>=1 && y <= Y_MAX)
			self.locations.where(x:x,y:y).empty?
		else
			false
		end
	end

	def check_for_hit(x,y)
		hit_location = self.locations.find_by(x:x,y:y)
		if(hit_location.nil?)
			loc = Location.new(x:x, y:y)
			loc.state == Location::LOCATION_STATE_MAP[Location::MISS]
			loc.save
			self.locations << loc
			hit = false
		else
			hit_location.state = Location::LOCATION_STATE_MAP[Location::HIT]
			hit_location.save
			hit = true
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
				end
				break
			end
		end
		sunk
	end

	def check_for_all_sunk
		if self.ships.find_by(sunk_state:true).count == Ship::SHIPTYPE_LENGTH_MAP.keys.length
			true
		else
			false
		end
	end

end