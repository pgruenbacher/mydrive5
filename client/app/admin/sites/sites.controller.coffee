'use strict'

angular.module 'mydrive5App'
.controller 'SitesCtrl', ($scope) ->
  $scope.message = 'Hello'
  $scope.createVisible = false

  $scope.showCreate = ->
    $scope.createVisible = true

  $scope.newSite=
    siteName : 'Example'
    menuItems : [
      {
        title:'Registration'
        sub:[{title:'Participant'},{title:'Volunteer'}]
      },
      {
        title:'Donate'
        sub:[{title:'Donate to Participant'},{title:'Donate to general fund'}]
      },
      {
        title:'The Event(s)'
        sub:[{title:'When and Where'}]
      },
      {
        title:'Community'
        sub:[{title:'News'},{title:'Small Events'}]
      },
      {
        title:'About'
        sub:[{title:'History/Inspiration'},{title:'Sponsors'},{title:'Contact Us'}]
      }
    ]

  $scope.subExists=(item)->
    console.log(item.sub.length>0)
    return item.sub.length>0

  $scope.deleteSubMenuItem=(parent,index)->
    $scope.newSite.menuItems[parent].sub.splice(index,1)

  $scope.addSubMenuItem=(index)->
    $scope.newSite.menuItems[index].sub.push({title:''})

  $scope.deleteMenuItem = (index)->
    $scope.newSite.menuItems.splice(index,1)

  $scope.addMenuItem = ->
    $scope.newSite.menuItems.push({title:'',sub:[]})
