'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites.site',
    url: '/:site'
    templateUrl: 'app/admin/sites/site/site.html'
    controller: 'SiteCtrl'
    resolve:
      site: (Sites,$stateParams)->
        return Sites.query({domainName:$stateParams.site})
        .then (response)->
          return response.data[0]
        , (err)->
          return err

  .state 'app.admin.sites.site.page',
    url: '/:page'
    templateUrl:'components/mysite/myPage/page.html'
    controller:'PageCtrl'
    


