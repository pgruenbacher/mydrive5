'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.login',
    url: '/login'
    templateUrl: 'app/account/login/login.html'
    controller: 'LoginCtrl'

  .state 'app.logout',
    url: '/logout?referrer'
    referrer: 'app.main'
    controller: ($state, Auth) ->
      referrer = $state.params.referrer or $state.current.referrer or "app.main"
      console.log referrer
      Auth.logout()
      $state.go referrer

  .state 'app.signup',
    url: '/signup'
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupCtrl'

  .state 'app.settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true

.run ($rootScope) ->
  $rootScope.$on '$stateChangeStart', (event, next, nextParams, current) ->
    next.referrer = current.name  if next.name is "logout" and current and current.name and not current.authenticate

