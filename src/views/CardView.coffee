class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->

    rank = @.model.get('rankName')
    suit = @.model.get('suitName')

    @$el.children().detach()
    # @$el.html @template @model.attributes

    @$el.css {
      'background-image':'url(./img/tarot/'+rank+'-'+suit+'.png)'
      'background-size': 'cover'
    }

    @$el.addClass 'covered' unless @model.get 'revealed'

