'use strict'

angular.module 'mydrive5App'
.factory 'Sites', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  query:(obj)-> 
    $http.get '/api/sites/find', {params:obj}

  update:(id,data)->
    console.log data
    $http.put '/api/sites/'+id, data

  setPage:(id,pageId,data)->
    $http.put '/api/sites/'+id+'/menu/'+pageId, data

  setSubPage:(id,pageId,subId,data)->
    $http.put '/api/sites/'+id+'/menu/'+pageId+'/sub/'+subId, data

  findPage:(site,domainName)->
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
