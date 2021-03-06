class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2 class=<% if(isDealer){ %>Dealer<% }else{ %>You<% } %>>
                        <% if(isDealer){ %>Dealer<% }else{ %>You<% } %>
                        (<span class="score"></span>) <span class="money">$<%=wallet%></span></h2>'

  initialize: ->
    # @collection.on 'bet', => @render()
    @$('.score').text @collection.scores()[0]
    # @collection.on 'end', => @trigger 'end'
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]




