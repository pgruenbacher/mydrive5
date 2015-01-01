'use strict'

angular.module 'mydrive5App', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'btford.socket-io',
  'ui.router',
  'ui.bootstrap',
  'angularFileUpload',
  'ngCkeditor',
  'angularPayments'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
  $httpProvider.interceptors.push 'authInterceptor'

.config ($stateProvider)->
  $stateProvider
  .state 'app',
    abstract:true
    templateUrl: 'app/app.html'

.factory 'authInterceptor', ($rootScope, $q, $cookieStore, $injector) ->
  state = null
  # Add authorization token to headers
  request: (config) ->
    config.headers = config.headers or {}
    config.headers.Authorization = 'Bearer ' + $cookieStore.get 'token' if $cookieStore.get 'token'
    config

  # Intercept 401s and redirect you to login
  responseError: (response) ->
    if response.status is 401
      (state || state = $injector.get '$state').go 'app.login'
      # remove any stale tokens
      $cookieStore.remove 'token'

    $q.reject response

.run ($rootScope, $state, Auth) ->
  # Redirect to login if route requires auth and you're not logged in
  $rootScope.$on '$stateChangeStart', (event, next) ->
    Auth.isLoggedIn (loggedIn) ->
      $state.go 'login' if next.authenticate and not loggedIn

