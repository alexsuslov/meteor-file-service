self = @
@files = new Meteor.Collection 'files'
@files.allow
  insert: (userId, myFile) ->
    true

@files.allow
  insert: (userId, doc)->
    true
  update:(userId, docs, fields, modifier)->
    true if docs.owner is userId
  remove:  (userId, docs)->
    true if docs.owner is userId

if Meteor.isServer
  Meteor.publish "files", ()->
    self.files.find({},sort:filename:1)

