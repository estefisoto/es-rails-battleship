class Location < ActiveRecord::Base
	attr_accessible :x, :y, :state
	belongs_to :ocean
	belongs_to :ship
	# Location States
	OPEN = 'Open'.freeze
	OCCUPPIED = 'Occuppied'.freeze
	HIT = 'Hit'.freeze
	MISS = 'Missed'.freeze
	
	LOCATION_STATE_MAP = {
		Location::OPEN 		 => 0,
		Location::OCCUPPIED => 1,
		Location::HIT  		 => 2,
		Location::MISS 	   => 3
	}

	def attack_update_state
		if self.state == Location::LOCATION_STATE_MAP[Location::OPEN]
			self.sate = Location::Missed
		else self.state == Location::LOCATION_STATE_MAP[Location::OCCUPPIED]
			self.state =  Location::HIT
		end
	end

	def is_occuppied?
		self.state == Location::LOCATION_STATE_MAP[Location::OCCUPPIED]
	end 

	def is_hit?
		self.state == Location::LOCATION_STATE_MAP[Location::HIT]
	end

	def is_open?
		self.state == Location::LOCATION_STATE_MAP[Location::OPEN]
	end

end