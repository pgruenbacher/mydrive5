'use strict'

angular.module 'mydrive5App'
.factory 'Sites', ($http)->
  navigationItems=[]
  # AngularJS will instantiate a singleton by calling 'new' on this function
  all:()->
    $http.get '/api/sites'

  query:(obj)-> 
    $http.get '/api/sites/find', {params:obj}

  get:(domainName)->
    $http.get '/api/sites/'+domainName

  update:(id,data)->
    console.log data
    $http.put '/api/sites/'+id, data

  setNavigationItems:(site)->
    navigationItems=[]
    for menuItem in site.menuItems
      if menuItem.sub.length
        for subItem in menuItem.sub
          navigationItems.push subItem.slug
      else
        navigationItems.push menuItem.slug
    return navigationItems
  getNavigationItems:->
    navigationItems

  setHome:(id,data)->
    $http.put '/api/sites/'+id+'/home', data

  setPage:(id,pageId,data)->
    $http.put '/api/sites/'+id+'/menu/'+pageId, data

  setSubPage:(id,pageId,subId,data)->
    $http.put '/api/sites/'+id+'/menu/'+pageId+'/sub/'+subId, data

  findPage:(site,domainName)->
    if domainName == 'home'
      return site.homePage
    for key,menuItem of site.menuItems
      menuItem.parentIndex=key
      if menuItem.slug == domainName
        return menuItem
      if menuItem.sub.length > 0
        for skey,subItem of menuItem.sub
          subItem.grandParentIndex=key
          subItem.parentIndex=skey

          if subItem.slug == domainName
            return subItem

  savePage:(site,data)->
    if(data.parentId && data.parentIndex && data.grandParentIndex)
      return @setSubPage(site._id,data.parentId, data.id, data)
    else if(data.parentIndex)
      return @setPage(site._id,data.parentId,data)
    else
      return @setHome(site._id,data)
