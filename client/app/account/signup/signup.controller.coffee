'use strict'

angular.module 'mydrive5App'
.controller 'SignupCtrl', ($scope, Auth, $state, $window,$timeout) ->
  $scope.user={}
  $timeout ->
    $scope.user =
      email:'pgruenbacher@gmail.com'
      firstName:'paul'
      lastName:'gruen'
      phoneNumber:'(513) 319-8238'
      dob: new Date()
      businessName:'something name'
      productDescription:'description description'
      businessType:'sole_prop'
      zip:45014
      streetAddress:'1867 Harrowgate'
      state:'OH'
      city:'fairfield'
  , 300

  $scope.errors = {}

  $scope.fields=
      email:
        name:'email'
        type:'textfield'
        label:'email'
        required:true
      firstName:
        name:'firstName'
        type:'textfield'
        label:'first name'
        required:true
      lastName:
        name:'lastName'
        type:'textfield'
        label:'last name'
        required:true
      phoneNumber:
        name:'phoneNumber'
        type:'phoneNumber'
        label:'phone number'
        required:true
      dob:
        name:'dob'
        type:'date'
        label:'date of birth'
        required:true
      businessName:
        name:'businessName'
        type:'textfield'
        label:'your organization name'
        required:true
      productDescription:
        name:'productDescription'
        label:'organization description'
        type:'textarea'
        minlength:20
        maxlength:500
      businessType:
        name:'businessType'
        label:'business type'
        type:'options'
        placeholder:'--type--'
        selects:[
          {value:'sole_prop',name:'Sole Proprietorship'}
          {value:'corporation',name:'Corporation'}
          {value:'non_profit', name:'Non Profit'}
          {value:'partnership',name:'Partnership'}
          {value:'llc',name:'LLC'}
        ]
      zip:
        name:'zip'
        label:'zipcode'
        type:'textfield'
        required:true
      streetAddress:
        name:'streetAddress'
        label:'street address'
        type:'textfield'
        required:true
      city:
        name:'city'
        label:'city'
        type:'textfield'
        required:true
      state:
        name:'state'
        type:'states'
        placeholder:'--state--'
        required:true
        label:'select state'



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

      if typeof $scope.user.dob =='string'
        date=$scope.user.dob.split('/')
      else
        date= new Date($scope.user.dob)
        date=[date.getMonth()+1,date.getDate(),date.getFullYear()]

      console.log date
      user.day=date[1]
      user.month=date[0]
      user.year=date[2]
      user.phoneNumber=user.phoneNumber.replace(/\D/g,'')
      # url=$location.path('/auth/'+provider).search(user)
      url='/auth/'+provider+'/?'+decodeURIComponent($.param(user))
      # console.log url, user
      $window.location.href = url
