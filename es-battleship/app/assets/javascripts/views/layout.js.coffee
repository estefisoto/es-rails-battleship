#= require templates/layout
Estefis.Views ?= {}
class Estefis.Views.Layout extends Backbone.Marionette.LayoutView
  template: 'templates/layout'

  regions:
    'banner':            		'.mr-banner'
    'playerContainer':   		'.mr-player-container'
    'boardContainer':    		'.mr-board-container'
    'gameStateContainer':   '.mr-game-state-container'

  initialize: (options) ->