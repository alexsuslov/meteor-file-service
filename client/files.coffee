self= @
# Use session for setting filter options
Session.setDefault "imagesFilter",
  completed: true
  limit: 30

# Make subscription depend on the current filter
# Deps.autorun ->
  # filter = Session.get("imagesFilter")
  # Meteor.subscribe "imagesFS", filter

Template.image.events
  "change .fileUploader": (e) ->
    console.log e
    # files = e.target.files
    # i = 0
    # f = undefined

    # while f = files[i]
    #   self.imagesFS.storeFile f
    #   i++

# Template.images.helpers
#   Files: ->
#     self.imagesFS.find {},
#       sort:
#         uploadDate: -1

  # view: (item)->
  #   console.log item
  #   id = item._id
  #   self.imagesFS.retrieveBlob id, (fileItem)->
  #     if (fileItem.blob)
  #       file = fileItem.blob
  #     else
  #       file = fileItem.file
  #     item =
  #       filename:fileItem.filename
  #       file:file
  #     console.log item


Template.images.events
  "click .btnFileSaveAs": (e)->
    console.log e
    # self.imagesFS.retrieveBlob @_id, (fileItem) ->
    #   console.log fileItem
    #   if fileItem.blob
    #     self.saveAs fileItem.blob, fileItem.filename
    #   else
    #     self.saveAs fileItem.file, fileItem.filename