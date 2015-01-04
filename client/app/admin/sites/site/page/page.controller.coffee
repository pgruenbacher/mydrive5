'use strict'

angular.module 'mydrive5App'
.controller 'PageCtrl', ($scope,$stateParams) ->
  default1='<h1>Hello, world!</h1><p>This is a template for a simple welcome website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>'
  about1='';
  $scope.templates=[
    {
      src:'defaultLayout'
      label:'welcome'
      default:
        block3:default1
        block2:default1
        block1:default1
        header1:default1
    }
    {
      src:'blogLayout'
      label:'blog'
      blog:
        header:'<h1>My blog header</h1>'
        subHeader:'<h2>This is my blog subheader</h2>'
        about:'<p><em>This is my about section.</em>This is my about section, I can edit it any way that I may want. I may edit it any way that I want</p>'
    }
    {src:'participantLayout'
    label:'participant profile'}
    {src:'eventInfoLayout'
    label:'event info'}
  ]

  findPage=(site,domainName)->
    for key,menuItem of site.menuItems
      if menuItem.slug == domainName
        return menuItem
      if menuItem.sub.length > 0
        for skey,subItem of menuItem.sub
          if subItem.slug == domainName
            return subItem

  $scope.page=findPage($scope.$parent.site,$stateParams.page)  
  console.log $scope.page.template
  if typeof $scope.page.template == 'undefined'
    $scope.page.template=$scope.templates[0]



  

