'use strict'

angular.module 'mydrive5App'
.directive 'ticker', ($interval,$filter,$compile)->
  easeOutCubic=(currentIteration, startValue, changeInValue, totalIterations) ->
    changeInValue * (Math.pow(currentIteration / totalIterations - 1, 3) + 1) + startValue;

  easeInCubic=(currentIteration, startValue, changeInValue, totalIterations)->
    changeInValue * Math.pow(currentIteration / totalIterations, 3) + startValue;

  zeroPad=(num, places)->
    zero = places - num.toString().length + 1
    Array(+(zero > 0 && zero)).join("0") + num

  parseSeconds = (seconds)->
    sec_num = parseInt(seconds, 10)
    hours   = Math.floor(sec_num / 3600)
    minutes = Math.floor((sec_num - (hours * 3600)) / 60)
    seconds = sec_num - (hours * 3600) - (minutes * 60)

    if (hours   < 10)
      hours   = "0"+hours
    if (minutes < 10)
      minutes = "0"+minutes
    if (seconds < 10)
      seconds = "0"+seconds
    time = hours+':'+minutes+':'+seconds;
    return time;


  restrict: 'EA',
  scope:
    value:'@value',
    method:'@method'
  link: (scope, element, attrs) ->    
    if scope.method == 'dollars'
      element.addClass 'tick tick-scroll dollar-container'

      if element.next().length
        console.log 'insert before'
        element.next().insertBefore(element)

      contentTr = angular.element('<div class="dollar-append">$</div>')
      contentTr.insertAfter(element)
      $compile(contentTr)(scope)

      iteration=0
      stopAt=10
      startNumber=0
      string=($filter('number')(scope.value,0))
      string=string.replace(/[0-9]/g, '0')
      string='1'+string.slice(1)
      element.text string

      ticker=element.ticker
        delay:500
        separators:true
        incremental:(current)->
          if iteration<stopAt
            iteration++
            this.options.delay=easeOutCubic iteration, 20, 500, stopAt
            value=parseInt easeInCubic iteration, 0, scope.value, stopAt
          else
            this.options.delay=2000
            value=scope.value
          zeroPad(value,scope.value.toString().length)

    if scope.method == 'days'

      iteration=0
      stopAt=4
      startNumber=0
      
      element.addClass('tick tick-flip')
      # contentTr = angular.element('<div class="day-label">Days Left</div>')
      # contentTr.insertAfter(element)
      # $compile(contentTr)(scope)

      now = scope.value - 10 * 60 * 60
      console.log scope.value, now
      timeLeft = Math.ceil((scope.value-now))

      daysLeft = Math.ceil(timeLeft/60/60)

      element.text daysLeft

      ticker=element.ticker
        delay:500
        separators:true
        incremental:(current)->
          if iteration<stopAt
            iteration++
            this.options.delay=easeOutCubic iteration, 20, 500, stopAt
            value=parseInt easeInCubic iteration, daysLeft*5, -daysLeft*4, stopAt
          else
            this.options.delay=2000
            value=daysLeft






    

    
    

    false