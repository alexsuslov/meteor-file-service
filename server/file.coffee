fs = Npm.require('fs')

Meteor.methods
  getFile:(objFile)->
    if objFile
      path = './upload/' + objFile.path + '/' + objFile.filename
      # console.log path
      if fs.existsSync path
        # console.log 'file exists'
        fs.readFileSync( path).toString()
      else
        false
    else
      false