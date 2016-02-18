#= require templates/layout
#= require views/board

Estefis.Views ?= {}
class Estefis.Views.Layout extends Backbone.Marionette.LayoutView
  template: 'templates/layout'

  regions:
    'banner':            		'.mr-banner'
    'playerContainer':   		'.mr-player-container'
    'boardContainer':    		'.mr-board-container'
    'gameStateContainer':   '.mr-game-state-container'

  initialize: (options) ->
  	console.log("In Game layour initialize")
  	@playerBoardView = new Estefis.Views.Board({row_count: 10,col_count: 10})

  onShow: ->
  	@boardContainer.show @playerBoardView