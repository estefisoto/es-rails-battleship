class Ocean < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	belongs_to :game
	belongs_to :player
end