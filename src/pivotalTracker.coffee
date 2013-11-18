class PivotalTracker

  constructor: ->
    @options = new Options
    #@apiToken = '19606ec65860bef997d8f5cc5c33d813'
    #@projectId = '903190'


  retreiveCards: ->

    setHeader = (xhr) =>
      xhr.setRequestHeader('X-TrackerToken', "#{@options.apiToken}")


    popup = new Application.popup()

    console.log @options.projects

    for project in @options.projects

      projectName = project.name

      $.ajax
        url: "https://www.pivotaltracker.com/services/v5/projects/#{project.id}/stories?date_format=millis&with_state=started"
        type: "GET"
        dataType: "json"
        success: (data) ->
          popup.createCardsList(data, projectName)

        error: ->
          alert "Sorry an error has occured"

        beforeSend: setHeader
