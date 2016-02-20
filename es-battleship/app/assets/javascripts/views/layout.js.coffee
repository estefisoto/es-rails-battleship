#= require templates/layout
#= require views/board

Estefis.Views ?= {}
class Estefis.Views.Layout extends Backbone.Marionette.LayoutView
  template: 'templates/layout'

  regions:
    'banner':            				'.mr-banner'
    'playerContainer':   				'.mr-player-container'
    'selfBoardContainer':    		'.mr-self-board-container'
    'opponentBoardContainer': 	'.mr-opponent-board-container'
    'gameStateContainer':   		'.mr-game-state-container'

  initialize: (options) ->
  	@playerBoardView = new Estefis.Views.Board
      row_count:options.row_count
      col_count:options.col_count
      locations: options.locations
      player_token: options.player_token

  	@opponentBoardView = new Estefis.Views.Board
      row_count:options.row_count
      col_count:options.col_count
      player_token: options.player_token

 		true

  onShow: ->
  	@selfBoardContainer.show @playerBoardView
  	@opponentBoardContainer.show @opponentBoardView
  	true