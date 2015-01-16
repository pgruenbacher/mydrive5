'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites.site',
    url: '/:site'
    abstract:true
    # templateUrl: 'app/admin/sites/site/site.html'
    template:'<ui-view></ui-view>'
    controller: 'SiteCtrl'
    ncyBreadcrumb:
      label:'site'
    resolve:
      site: (Sites,$stateParams)->
        return Sites.get($stateParams.site)
        .then (response)->
          return response.data[0]
        , (err)->
          return err

  .state 'app.admin.sites.site.page',
    url: '/:page'
    templateUrl:'app/admin/sites/site/page/page.html'
    controller:'PageCtrl'
    ncyBreadcrumb:
      label:'page'
    onExit: ($stateParams,site,Sites)->
      page=Sites.findPage(site,$stateParams.page)
      Sites.savePage(site,page)


