'use strict'

angular.module 'mydrive5App'
.controller 'SignupCtrl', ($scope, Auth, $state, $window) ->

  $scope.user =
    email:'pgruenbacher@gmail.com'
    firstName:'paul'
    lastName:'gruen'
    phoneNumber:'(513) 319-8238'
    dob: '05/08/1990'
    businessName:'something name'
    productDescription:'description description'
    businessType:'sole_prop'
    zip:45014
    streetAddress:'1867 Harrowgate'
    state:'OH'
    city:'fairfield'

  $scope.errors = {}




  $scope.register = (form) ->
    $scope.submitted = true

    if form.$valid
      # Account created, redirect to home
      Auth.createUser
        name: $scope.user.name
        email: $scope.user.email
        password: $scope.user.password

      .then ->
        $state.go 'main'

      .catch (err) ->
        err = err.data
        $scope.errors = {}

        # Update validity of form fields that match the sequelize errors
        if err.name
          angular.forEach err.fields, (field) ->
            form[field].$setValidity 'mongoose', false
            $scope.errors[field] = err.message

  $scope.loginOauth = (provider) ->
    if provider != 'stripe'
      $window.location.href = '/auth/' + provider
    else
      user=$scope.user
      date=$scope.user.dob.split('/')
      user.day=date[0]
      user.month=date[1]
      user.year=date[2]
      user.phoneNumber=user.phoneNumber.replace(/\D/g,'')
      # url=$location.path('/auth/'+provider).search(user)
      url='/auth/'+provider+'/?'+decodeURIComponent($.param(user))
      # console.log url, user
      $window.location.href = url
