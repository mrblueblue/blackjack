class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()

    # Listen for Dealer Turn

    @model.get('playerHand').on 'dealer-turn', =>
      @model.get('dealerHand').deal()

    # Listen for End Game

    winner = null
    player = @model.get('playerHand')
    dealer = @model.get('dealerHand')

    player.on 'bust', =>
      winner = dealer
      alert 'dealer wins', winner.isDealer

    dealer.on 'bust', =>
      winner = player
      alert 'player wins', winner.isDealer

    player.on 'end', =>
      if dealer.minScore() > player.minScore() then winner = dealer
      if dealer.minScore() < player.minScore() then winner = player
      if dealer.minScore() == player.minScore() then winner = player
      if winner == dealer
        alert 'the winner is the dealer'
      else
        alert 'the winner is the player'

    dealer.on 'end', =>
      if dealer.minScore() > player.minScore() then winner = dealer
      if dealer.minScore() < player.minScore() then winner = player
      if dealer.minScore() == player.minScore() then winner = player
      if winner == dealer
        alert 'the winner is the dealer'
      else
        alert 'the winner is the player'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

