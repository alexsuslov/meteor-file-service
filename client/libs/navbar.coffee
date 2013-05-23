self = @

Template.navbar.isHeader = ()->
  @class is 'nav-header'

Template.navbar.isDivider = ()->
  @class is 'divider'

Template.navbar.isDropdown = ()->
  @class is 'dropdown'

Template.navbar.list = ()->
  page = Session.get 'page'
  navbar = Session.get 'navbar'
  list = []
  for item of navbar
    menu = navbar[item]
    menu.class = 'active' if page is item
    list.push menu unless menu.hide
  list

# Session.set 'navbar',
#     orders:
#       displayName:'Файлы'
#       class:'dropdown'
#       dropdown:[
#         {
#           displayName:'Новый'
#           href:'/file/new'

#         }
#         {
#           class:'divider'
#         }
#         {
#           displayName:'Список'
#           href:'/files'
#         }
#       ]


