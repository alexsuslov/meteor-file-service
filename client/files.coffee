self= @
Meteor.subscribe "files"

Template.file.events
  'keyup: #tags':(e)->
    Session.set 'tags', e.target.val()

  "click .Upload": (e) ->
    srcElement = $('#fileUploader')[0]
    e.preventDefault()
    if Meteor.userId() and srcElement.files
      tags = $('#tags').val()
      _.each srcElement.files, (file)->
        console.log file
        reader = new FileReader()
        addFile = (objFile)->
          unless self.files.findOne( $or:[hash: objFile.hash, name: file.name] )
            self.files.insert objFile
          else
            console.log 'error file exist!'

        reader.onload = ()->
          md5 = CryptoJS.MD5(reader.result).toString()

          objFile =
            hash: md5
            filename: file.name
            path:  file.type
            tags: tags
            owner: Meteor.userId()
          addFile objFile
          Meteor.saveFile(file, file.name, file.type)

        reader.onerror = ()->
            console.error "Could not read the file"
        reader.readAsBinaryString file

Template.file.tags = ->
  Session.get 'tags'
###
Files
###

Template.files.events
  'click button#filter':(e)->
    Session.set 'filter', $('input#filter').val()
  'click a.fast':(e)->
    e.preventDefault()
    opt = 'fastFile'
    if Session.get opt
      Session.set opt, false
    else
      Session.set opt, true
  "click .rm": (e) ->
    self.files.remove @_id

Template.files.fast = ()->
  Session.get 'fastFile'

Template.files.Files = ()->
  search = {}
  limit= limit:50
  filter = Session.get 'filter'
  if filter
    re = new RegExp(filter ,'gi')
    search = tags:re
  self.files.find(search, limit)