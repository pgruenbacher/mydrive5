'use strict'

angular.module 'mydrive5App'

.directive 'paperCheckbox', ($templateCache)->
  templateUrl: 'components/mysite/myForm/paper/paperCheckBox.html'
  scope:
    data: '='
    field: '='
  link:(scope,element,attrs)->
    label = element.find('label')
    input = element.find('input')
    scope.cssClass = ''
    scope.animationDir = ''

    scope.invokeAnimation = ->
      scope.cssClass = scope.cssClass == '' ? 'circle' : ''
      scope.animationDir = scope.animationDir == '' ? true : !scope.animationDir

    label.on 'click', (evt)->

       # find the first span which is our circle/bubble
      el = angular.element(this).children().eq(0)
      newone = null
      circleSpanElements = null

       # add the bubble class (we do this so it doesnt show on page load)
      el.addClass('circle')

       # clone it
      newone = el.clone(true)

       # add the cloned version before our original
      el.after(newone)
      # el[0].insertAdjacentHTML('beforebegin', newone[0])

      # remove the original so that it is ready to run on next click
      circleSpanElements = label[0].querySelectorAll('.circle')
      angular.element(circleSpanElements).eq(0).remove()
      # scope.$apply(function(){});

      
# .directive 'paperInputDate',($templateCache)->
#   templateUrl:'components/mysite/myForm/fieldTemplates/paperinput.html'
#   scope:
#     label: '@',
#     type: '@',
#     modelRef: '='
#     link:(scope,element,attrs)->
#       scope.isRequired = angular.isDefined(attrs.required)
#       scope.isDatepicker = angular.isDefined(attrs.date)
#       scope.state =
#         opened : false
#       if (scope.isDatepicker)
#         scope.openDatePicker = ($event)->
#           # // event.preventDefault(event);
#           # // event.stopPropagation();
#           scope.state.opened = true


# .directive 'paperInputDate', ($templateCache)->
#   templateUrl:'components/mysite/myForm/fieldTemplates/paperInputDate.jade'
#     scope: {
#       label: '@',
#       type: '@',
#       modelRef: '='
#   compile:(tElement,tAttrs)->
#     groupEl = tElement[0].querySelector('.paper-input')
#     input = tElement[0].querySelector('input')
#     # // if(tAttrs.date){
#     groupEl.setAttribute('ng-click','openDatePicker($event)');
#     input.setAttribute('is-open','state.opened');
#     input.setAttribute('datepicker-popup','dd.MM.yyyy');
#     # // }
#     return (scope, element, attrs)->
#       scope.isRequired = angular.isDefined(attrs.required);
#       scope.state =
#         opened : false
#       scope.openDatePicker = ($event)->
#         event.preventDefault(event)
#         event.stopPropagation()
#         scope.state.opened = true