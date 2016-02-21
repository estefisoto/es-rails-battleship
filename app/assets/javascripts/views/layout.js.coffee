#= require templates/layout
#= require views/board
#= require views/game_status
#= require views/waiting

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
    @turn = options.turn
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
      turn: @turn

    @playerBoardView.on "game:turn", =>
      playerTurnStatusView = new Estefis.Views.GameStatus
        inProgress: true
      @updateGameStatus playerTurnStatusView
      @opponentBoardView.turn = true

    @playerBoardView.on "game:lost", =>
      lostStatusView = new Estefis.Views.GameStatus
        won:false
      @updateGameStatus lostStatusView

    @opponentBoardView.on "game:won", =>
      wonStatusView = new Estefis.Views.GameStatus
        won:true
      @updateGameStatus wonStatusView

    @opponentBoardView.on "game:wait", =>
      waitingStatusView = new Estefis.Views.Waiting
      @updateGameStatus waitingStatusView
      @opponentBoardView.turn = false
      
    # Subscribe to player's channel to get/display actions from opponent player
    @subscribeToChannel()
    true

  onShow: ->
    @selfBoardContainer.show @playerBoardView
    @opponentBoardContainer.show @opponentBoardView
    if @turn
      playerTurnStatusView = new Estefis.Views.GameStatus
        inProgress: true
      @gameStateContainer.show playerTurnStatusView
    else
      waitingStatusView = new Estefis.Views.Waiting
      @gameStateContainer.show waitingStatusView
    true

  subscribeToChannel: ->
    channelName = Estefis.ChannelBaseName + @token
    PrivatePub.subscribe(channelName, (data) =>
      @playerBoardView.trigger "opponent:action", data)
    return

  showPlayerTurn: ->
    @gameStateContainer.reset()
    @gameStateContainer.show @playerTurnView

  updateGameStatus: (view) ->
    @gameStateContainer.show view