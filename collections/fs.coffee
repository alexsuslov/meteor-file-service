# self = @
# @imagesFS = new CollectionFS 'images',autopublish: false
# @imagesFS.allow
#   insert: (userId, myFile) ->
#     true

#   update: (userId, files, fields, modifier) ->
#     true
#     # _.all files, (myFile) ->
#     #   userId is myFile.owner

#   remove: (userId, files) ->
#     false
# if Meteor.isServer
#   Meteor.publish "imagesFS", (filter) ->

#     # sort by handledAt time and only return the filename, handledAt and _id fields
#     self.imagesFS.find
#       complete: filter.completed
#     ,
#       sort:
#         handledAt: 1

#       fields:
#         _id: 1
#         filename: 1
#         handledAt: 1

#       limit: filter.limit

