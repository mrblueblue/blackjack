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
      console.log('deal')
      @model.get('dealerHand').deal()

    # Listen for End Game

    winner = null
    player = @model.get('playerHand')
    dealer = @model.get('dealerHand')

    dealerWins= ->
      winner = 'Dealer'
      $('.Dealer').addClass 'winner'
      $('.You').addClass 'loser'
      return

    playerWins=  ->
      winner = 'You'
      $('.Dealer').addClass 'loser'
      $('.You').addClass 'winer'
      return

    player.on 'bust', =>
      dealerWins()

    dealer.on 'bust', =>
      playerWins()

    player.on 'end', =>
      if dealer.minScore() > player.minScore() then dealerWins()
      if dealer.minScore() < player.minScore() then playerWins()
      if dealer.minScore() == player.minScore() then playerWins()

    dealer.on 'end', =>
      if dealer.minScore() > player.minScore() then dealerWins()
      if dealer.minScore() < player.minScore() then playerWins()
      if dealer.minScore() == player.minScore() then playerWins()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

