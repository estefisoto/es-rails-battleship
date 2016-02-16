class Ship < ActiveRecord::Base
	attr_accessible :kind
	has_many :locations, dependent: :destroy
	belongs_to :ocean
	# Ship Kind
	AIRCRAFT_CARRIER = 'Aircraft Carrier'.freeze
	BATTLESHIP = 'Battleship'.freeze
	SUBMARINE = 'Submarine'.freeze
	CRUISER = 'Crusier'.freeze
	DESTROYER = 'Destroyer'.freeze
	
	SHIPTYPE_LENGTH_MAP = {
		Ship::AIRCRAFT_CARRIER => 5,
		Ship::BATTLESHIP 			 => 4,
		Ship::SUBMARINE 			 => 3,
		Ship::CRUISER 				 => 3,
		Ship::DESTROYER 			 => 2
	}

	def ship_legth
		Ship::SHIPTYPE_LENGTH_MAP[self.kind]
	end

end