self = @
Meteor.subscribe "files"

marked.setOptions
  gfm: true
  tables: true
  breaks: false
  pedantic: false
  sanitize: true
  smartLists: true
  langPrefix: "language-"
  highlight: (code, lang) ->
    return highlighter.javascript(code)  if lang is "js"
    code

link = (objFile)->
  Session.set 'content', Template.link objFile


markdown = (objFile)->
  Meteor.call 'getFile', objFile, (err,resp)->
    console.log err if err
    if resp

      Session.set 'content', "<div class=\"md\">" + marked( resp) + "</div>"

Template.printView.content = Template.fileView.content = ()->
  Session.get 'content'

Template.printView.rend = Template.fileView.rend = ()->
  filename = Session.get 'file'
  objFile = self.files.findOne filename:filename
  if objFile
    # console.log objFile.type
    switch objFile.type
      when 'text/x-markdown'
        markdown objFile
      else
        link objFile

Template.link.url = ()->
  Meteor.absoluteUrl()