class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> 
    <button class="bet-button">Bet</button> <form><input type=text></input></form>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').dealerTurn()

  initialize: ->

    @render()

    # Listen for Dealer Turn

    # @model.get('playerHand').on 'dealer-turn', =>
    #   @model.get('dealerHand').deal()

    # Listen for End Game

    winner = null
    player = @model.get('playerHand')
    dealer = @model.get('dealerHand')

    dealerWins= ->
      $('.Dealer').addClass 'winner'
      $('.You').addClass 'loser'
      return

    playerWins=  ->
      $('.Dealer').addClass 'loser'
      $('.You').addClass 'winner'
      return

    player.on 'bust', =>
      dealerWins()

    player.on 'end', =>
      if dealer.minScore() > player.minScore() and dealer.minScore() <= 21 then dealerWins()
      else
        playerWins()

    dealer.on 'end', =>
      if dealer.minScore() > player.minScore() and dealer.minScore() <= 21 then dealerWins()
      else
        playerWins()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

