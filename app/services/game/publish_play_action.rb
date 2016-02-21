class PublishPlayAction

	# Publish to opponent's channel 
	def initialize(player:, message:)
		raise ArgumentError.new("player cannot be nil") if player.nil?
 		raise ArgumentError.new("message cannot be nil") if message.nil?
 		@channel = "#{Rails.application.config.channel_base_name }#{player.token}"
		@message = message
	end

	def call
		PrivatePub.publish_to @channel, @message
	end

end