class Ship < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	belongs_to :player
	# Ship Types
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

	def self.ship_legth(ship_type)
		Ship::SHIPTYPE_LENGTH_MAP[ship_type]
	end

end