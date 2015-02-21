class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer, @wallet, @bet) ->


  hit: ->
      @add(@deck.pop())
      if !@isDealer and @minScore() > 21 then @trigger 'bust'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    [@minScore(), @minScore() + 10 * @hasAce()]

  dealerTurn: ->
    if @isDealer
      @first().flip()
      if @minScore() >= 17
        @trigger 'end'
      else
        while @minScore() <= 17
          @hit()
        @trigger 'end'


