#= require templates/layout
#= require views/board
#= require views/game_status

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
    @token = options.playerToken
    @playerBoardView = new Estefis.Views.Board
      rowCount:options.rowCount
      colCount:options.colCount
      locations: options.locations
      playerToken: options.playerToken

    @opponentBoardView = new Estefis.Views.Board
      rowCount:options.rowCount
      colCount:options.colCount
      playerToken: options.playerToken
      opponent: true

    @gameStatusView = new Estefis.Views.GameStatus
      inProgress: true

    @playerBoardView.on "game:lost", =>
      @won = false
      @updateGameStatus()

    @opponentBoardView.on "game:won", =>
      @won = true
      @updateGameStatus()

    # Subscribe to player's channel to get/display actions from opponent player
    @subscribeToChannel()
    true

  onShow: ->
    @selfBoardContainer.show @playerBoardView
    @opponentBoardContainer.show @opponentBoardView
    @gameStateContainer.show @gameStatusView
    true

  subscribeToChannel: ->
    channelName = Estefis.ChannelBaseName + @token
    PrivatePub.subscribe(channelName, (data) =>
      @playerBoardView.trigger "opponent:action", data
    )
    return

  updateGameStatus: ->
    @gameStateContainer.reset()
    if @won
      @gameStatusView = new Estefis.Views.GameStatus
        won: true
      @gameStateContainer.show @gameStatusView
    else
      @gameStatusView = new Estefis.Views.GameStatus
        won: false
      @gameStateContainer.show @gameStatusView