'use strict'

angular.module 'mydrive5App'
.controller 'SitesCtrl', ($scope,$http,Sites,$state) ->
  
  Sites.all()
  .then (response)->
    $scope.sites=response.data
  
  $scope.editSite = (site)->
    console.log site
    $state.go('app.admin.sites.site',{site:site.domainName})


  newSite={}
  $scope.createVisible = false
  $scope.showCreate = ->
    $scope.site=newSite
    $scope.createVisible = true

  $scope.choice=[
    [204,95,67]
    [210,66,91]
    [194,124,107]
    [225,63,41]
  ]
  $scope.custom=(key)->
    r=$scope.choice[key][0]
    g=$scope.choice[key][1]
    b=$scope.choice[key][2]
    yiq = ((r*299)+(g*587)+(b*114))/1000;
    color= if yiq>=128 then '#333333' else 'white'
    style=
      'background-color':$scope.choice[0].string
      'color': color

  newSite=
    siteName : 'Example'
    homePage: {
      title:'Your Name'
    }
    menuItems : [
      {
        title:'Registration'
        sub:[
          {title:'Participant'},
          {title:'Volunteer'}
        ]
      },
      {
        title:'Donate'
        sub:[
          {title:'Donate to Participant'},
          {title:'Donate to general fund'}
        ]
      },
      {
        title:'The Event(s)'
        sub:[
         {title:'When and Where'}
        ]
      },
      {
        title:'Community'
        sub:[
          {title:'News'},
          {title:'Small Events'}
        ]
      },
      {
        title:'About'
        sub:[
          {title:'History/Inspiration'},
          {title:'Sponsors'},
          {title:'Contact Us'}
        ]
      }
    ]

  $scope.deleteSubMenuItem=(parent,index)->
    $scope.site.menuItems[parent].sub.splice(index,1)

  $scope.addSubMenuItem=(index)->
    $scope.site.menuItems[index].sub.push({title:''})

  $scope.deleteMenuItem = (index)->
    $scope.site.menuItems.splice(index,1)

  $scope.addMenuItem = ->
    $scope.site.menuItems.push({title:'',sub:[]})

  $scope.saveSite = ->
    $http.post '/api/sites', $scope.site
    .then (response)->
      $state.go('app.admin.sites.site',{site:response.data.domainName})
    , (error)->
    

