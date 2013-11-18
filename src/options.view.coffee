$ ->
  options = new Options
  options.fillOptionsPage()
  options.triggerApiTokenChanges()
  options.triggerProjectChanges()
  if options.apiToken?
    options.findProjects()
