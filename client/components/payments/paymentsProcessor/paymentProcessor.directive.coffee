'use strict'

angular.module 'mydrive5App'
.directive 'paymentProcessor', ($modal)->
  template: '<div ng-transclude="true"></div>'
  transclude:true
  restrict: 'EA'
  link: (scope, element, attrs) ->
    # paymentButton=angular.element(element[0].querySelector('.payment-button'))
    # console.log paymentButton
    # paymentButton.attr('ng-click','openPaymentModal()')
    scope.openPaymentModal=->
        $modal.open 
          size:'sm'
          controller:'paymentModalController'
          templateUrl:'app/payment/paymentProcessor/paymentModal.html'

.controller 'paymentModalController', ($scope,$modalInstance)->

  $scope.card={};
  
  $scope.handleStripe = (status, response)->
    console.log status,response
    

