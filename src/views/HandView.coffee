class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2 class=<% if(isDealer){ %>Dealer<% }else{ %>You<% } %>><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # @collection.on 'dealer-turn', => @dealer
    @collection.on 'bust', => @trigger 'ended'
    @collection.on 'add remove change', => @render()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

    