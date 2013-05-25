if Meteor.isClient
  Meteor.Router.add
    '': ()->
      if Meteor.user()
        'user'
      else
        'main'
    '/files': 'files'

    '/print/:name': (name)->
      Session.set 'file', name
      'printView'
    '/view/:name': (name)->
      Session.set 'file', name
      'fileView'
    '/file/:name': (name)->
      Session.set 'file', name
      'file'
    '/admin': 'admin'

  Template.body.helpers
    layoutName:()->
      if Meteor.Router.page()
        Meteor.Router.page()
      else
        '404'