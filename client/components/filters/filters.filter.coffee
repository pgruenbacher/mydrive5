'use strict'

angular.module 'mydrive5App'
.filter 'moment', ->
  (dateString, format)->
    moment(dateString).format(format)

.filter 'validPhoneNumber',->
  (number)->
    phoneRegex=/^(?:\([2-9]\d{2}\)\ ?|[2-9]\d{2}(?:\-?|\ ?))[2-9]\d{2}[- ]?\d{4}$/
    phoneRegex.test(number)

.filter 'validEmail',->
  (email)->
    emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    emailRegex.test(email)

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

