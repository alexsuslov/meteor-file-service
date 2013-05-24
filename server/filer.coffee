options = uploadDir: "./public/"
filer = new Filer(options)

filer.events
  file: (field, value) ->
    console.log field

  FileBegin: (name, file) ->
    console.log name

filer.allow ->
  true  if Meteor.userId()


filer.register "/upload"
