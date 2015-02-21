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
      callback =  -> alert('dealer wins')
      setTimeout callback, 500

    dealer.on 'bust', =>
      winner = player
      setTimeout alert ('player wins'), 5000

    player.on 'end', =>
      if dealer.minScore() > player.minScore() then winner = dealer
      if dealer.minScore() < player.minScore() then winner = player
      if dealer.minScore() == player.minScore() then winner = player
      if winner == dealer
        setTimeout alert ('the winner is the dealer'), 5000
      else
        setTimeout alert ('the winner is the player'), 5000

    dealer.on 'end', =>
      if dealer.minScore() > player.minScore() then winner = dealer
      if dealer.minScore() < player.minScore() then winner = player
      if dealer.minScore() == player.minScore() then winner = player
      if winner == dealer
        setTimeout alert('the winner is the dealer'), 5000
      else
        setTimeout alert('the winner is the player'), 5000

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

