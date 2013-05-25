self= @
fileSize = 5*1024*1024
Meteor.subscribe "files"

createType = (file)->
  if file.type
    file.type
  else
    # type from extention
    re = /(?:\.([^.]+))?$/
    ext = re.exec(file.name)[1]
    if ext is 'md' or ext is 'markdown'
      'text/x-markdown'

Template.file.events
  # 'keyup: #tags':(e)->
  #   Session.set 'tags', e.target.val()

  "click .Upload": (e) ->
    e.preventDefault()
    srcElement = $('#fileUploader')[0]
    Session.set 'fileErr', false
    if Meteor.userId() and srcElement.files
      tags = $('input#filter').val()
      if tags
        Session.set 'filter', tags
      _.each srcElement.files, (file)->

        if file.size < fileSize
          reader = new FileReader()
          addFile = (objFile)->
            unless self.files.findOne( $or:[hash: objFile.hash, name: file.name] )
              self.files.insert objFile
            else
              Session.set 'fileErr', 'error file exist!'
          reader.onload = ()->

            md5 = CryptoJS.MD5(reader.result).toString()
            type = createType file
            # file info

            objFile =
              hash: md5
              filename: file.name
              type: type
              path: type
              tags: tags
              owner: Meteor.userId()


            # add file info to mongo db
            addFile objFile
            # upload file
            Meteor.saveFile(file, file.name, type)

          reader.onerror = ()->
            Session.set 'fileErr', "Could not read the file"
          reader.readAsBinaryString file
        else
          Session.set 'fileErr', 'Ошибка! Файл больше 5Мб.'
          console.log "file to math!"

Template.file.err = ->
  Session.get 'fileErr'

Template.files.tags = ->
  Session.get 'filter'

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