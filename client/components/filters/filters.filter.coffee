'use strict'

angular.module 'mydrive5App'
.filter 'moment', ->
  (dateString, format)->
    moment(dateString).format(format)

.filter 'validSlug',->
  (title)->
    /^[a-z0-9]+(?:-[A-Za-z0-9]+)*$/.test(title)

.filter 'validPhoneNumber',->
  (number)->
    phoneRegex=/^(?:\([2-9]\d{2}\)\ ?|[2-9]\d{2}(?:\-?|\ ?))[2-9]\d{2}[- ]?\d{4}$/
    phoneRegex.test(number)

.filter 'validEmail',->
  (email)->
    emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    emailRegex.test(email)

.factory 'config', (CONFIG)->
  publicStatus=CONFIG.public
  config=
    public:->
      publicStatus
    setPublic:(bool)->
      console.log bool
      publicStatus=bool



.directive 'autoFillSync', ($timeout)->
  restrict:'A'
  require: 'ngModel'
  link:(scope, elem, attrs, ngModel)->
    origVal = elem.val();
    $timeout(()->
      newVal = elem.val();
      if ngModel.$pristine && origVal != newVal
        ngModel.$setViewValue(newVal);
    , 500)

.directive 'unique', ($injector)->
  require:'ngModel'
  scope:
    service:'@'
  link:(scope,elem,attr,ngModelCtrl)->
    service=$injector.get(scope.service,'unique directive')

    checkUnique=()->
      jsObj={}
      jsObj[attr.unique]=ngModelCtrl.$viewValue
      service.query jsObj
      .then (res)->
        console.log res.data.length
        ngModelCtrl.$setValidity('unique',res.data.length==0)

    ngModelCtrl.$viewChangeListeners.push ->
      checkUnique()




.directive 'filterValidation', ($filter)->
  require: 'ngModel'
  link:(scope, elem, attr, ngModel)->
    
    # /For DOM -> model validation
    ngModel.$parsers.unshift (value)->
      valid=$filter(attr.filterValidation)(value)
      ngModel.$setValidity('filter', valid)
      if valid then value else undefined

    # For model -> DOM validation
    # ngModel.$formatters.unshift (value)->
    #   ngModel.$setValidity('blacklist', blacklist.indexOf(value) == -1)
    #   value

.directive 'mask', ()->
  restrict: 'A',
  link: (scope, element, attrs) ->
    jQuery(element).mask(attrs.mask)
    
.directive 'onValidSubmit', ($parse, $timeout)->
  require: '^form'
  restrict: 'A'
  link:(scope, element, attrs, form)->
    form.$submitted = false
    fn = $parse(attrs.onValidSubmit)
    delay = (delay,callback)->$timeout callback,delay
    element.on 'submit',(event)->
      delay 100, ->
        scope.$apply ->
          element.addClass('ng-submitted')
          form.$submitted = true
          delay 100, ->
            if (form.$valid && !form.$invalid)
              if (typeof fn == 'function')
                fn scope, {$event: event}



# .directive 'ngEnter', ()->
#   (scope, element, attrs)->
#     element.bind "keydown keypress", (event)->
#       console.log event
#       if event.which == 13
#         scope.$apply ->
#           scope.$eval attrs.ngEnter
#         event.preventDefault()
