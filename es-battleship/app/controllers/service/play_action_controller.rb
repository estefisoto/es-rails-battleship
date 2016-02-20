class Service::PlayActionController < ApplicationController
	respond_to :json
	include GameHelper

	def hit
		x = params[:x]
		y = params[:y]
		player = get_player_from_token(params[:token])
		opponent_ocean = get_opponents_ocean(player: player)
		isHit = opponent_ocean.check_for_hit(x.to_i, y.to_i)
		action_results = {
			isHit: isHit
 		}
		if isHit && opponent_ocean.check_for_sunk(x.to_i, y.to_i)
			action_results[:gameOver] = opponent_ocean.check_for_all_sunk
		end
		render json: action_results
	end
end