class Application.popup

  constructor: ->
    @selector = "#cards"

  createCardsList: (cards, projectName) ->
    console.log @selector
    _selector = $("#{@selector}")
    _selector.append("<li><h5>#{projectName}</h5></li>")
    for card in cards
      console.log card
      html = "<li>#{card.name} [##{card.id}]</li>"
      _selector.append(html)


# Starts the new application popup
$ ->
  pv = new PivotalTracker()
  pv.retreiveCards()


