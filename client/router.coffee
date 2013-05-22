if Meteor.isClient
  Meteor.Router.add
    '': ()->
      if Meteor.user()
        'user'
      else
        'main'
    '/images': 'images'

    '/image/:name': (name)->
      Session.set 'image', name
      'image'
    '/admin': 'admin'

  Template.body.helpers
    layoutName:()->
      if Meteor.Router.page()
        Meteor.Router.page()
      else
        '404'