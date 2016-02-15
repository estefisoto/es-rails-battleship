class Location < ActiveRecord::Base
	attr_accessible :x, :y, :state
	belongs_to :ship
	belongs_to :ocean
	# Location States
	OPEN = 'Open'.freeze
	OCCUPIED = 'Occupied'.freeze
	HIT = 'Hit'.freeze
	MISS = 'Missed'.freeze
	
	LOCATION_STATE_MAP = {
		Location::OPEN 		 => 0,
		Location::OCCUPIED => 1,
		Location::HIT  		 => 2,
		Location::MISS 	   => 3
	}

	def attack_update_state
		if self.state == Location::LOCATION_STATE_MAP[Location::OPEN]
			self.sate = Location::Missed
		else self.state == Location::LOCATION_STATE_MAP[Location::OCCUPIED]
			self.state =  Location::HIT
		end
	end

	def is_hit?
		self.state == Location::LOCATION_STATE_MAP[Location::HIT]
	end

end