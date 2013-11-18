Options = {}


class Options

  constructor: ->
    @apiToken = localStorage['apiToken']
    if localStorage['projects']? && localStorage['projects'] != ""
      @projects = JSON.parse(localStorage['projects'])
    else
      @projects = []


  triggerApiTokenChanges: ->
    $("#apiToken").on "change", (e) =>
      @apiToken = $(e.currentTarget).val()
      localStorage['apiToken'] = @apiToken
      localStorage['projects'] = []
      @findProjects()
      return true

  triggerProjectChanges: ->
    $ ->
      $(document).on "click", ".project", (e) ->
        values = []
        for checked in $(".project:checked")
          values.push({name: $(checked).data("name"), id: $(checked).val()})

        localStorage['projects'] = JSON.stringify(values)
        console.log localStorage['projects']

  fillOptionsPage: ->
    $("#apiToken").val(@apiToken)

  findProjects: ->

    projectsUrl = "https://www.pivotaltracker.com/services/v5/projects"


    setHeader = (xhr) =>
      console.log @apiToken
      xhr.setRequestHeader('X-TrackerToken', "#{@apiToken}")

    $.ajax
      url: projectsUrl
      type: "GET"
      dataType: "json"
      success: (data) =>
        @fillProjectsList(data)

      error: ->
        alert "Sorry an error has occured"

      beforeSend: setHeader



  fillProjectsList: (projects) ->
    _selector = $("#projects")
    _selector.html("")


    for project in projects
      checked = ""
      checked = "checked" if "#{project.id}" in @projects.map (p) -> p.id

      html = "<li><input type='checkbox' value='#{project.id}' class='project' #{checked} data-name='#{project.name}'/>#{project.name}</li>"
      _selector.append(html)
