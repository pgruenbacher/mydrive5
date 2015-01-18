angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites.site.settings',
    url: '/settings'
    templateUrl:'app/admin/sites/site/siteSettings/siteSettings.html'
    controller: 'SiteSettingsCtrl'
    data:
      title: '{{site.siteName}} settings'