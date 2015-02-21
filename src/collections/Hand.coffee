class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer, @isWinner=false) ->

  hit: ->
    @add(@deck.pop())
    if @minScore() > 21
      @trigger 'bust'
      console.log 'bust triggered from hit'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    @trigger 'dealer-turn', @

  deal: ->
    if @isDealer
      @first().set 'revealed', true
      while @minScore() <= 17
        setTimeout @hit(), 1000
      @trigger 'end'


