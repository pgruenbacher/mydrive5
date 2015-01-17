'use strict'

angular.module 'mydrive5App'
.controller 'layoutCtrl', ($scope,service,selected,$injector)->
  Service=$injector.get(service)
  $scope.templates=Service.templates
  $scope.selected=selected
  $scope.select=(template)->
    $scope.selected=template

.controller 'PageCtrl', ($scope,$state,$stateParams,page,Sites,Pages,$location,$anchorScroll,$interval,config,$modal) ->
  $scope.pageSaving=false

  $scope.page=page

  $scope.editable=!config.public()
  
  $scope.preview=(bool)->
    config.setPublic(bool)
    $state.reload()
  
  $scope.save=(refresh)->
    $scope.pageSaving=true
    Sites.savePage($scope.site,$scope.page)
    .then (response)->
      console.log 'saved page',response
      if refresh
        $scope.site=response.data[0]
      $scope.pageSaving=false

  # !!!!!!Need to uncomment for autosaving!!!!
  # autosave = $interval $scope.save, 20000
  cancel = ->
    if typeof autosave != 'undefined'
      $interval.cancel(autosave)

  $scope.$on '$destroy', cancel

  $scope.changeLayout=->
    modalInstance=$modal.open
      templateUrl:'app/admin/sites/site/page/templatesModal.html'
      size:'lg'
      controller:'layoutCtrl'
      resolve:
        service:->
          'Pages'
        selected:->
          $scope.page.template

    modalInstance.result.then (result)->
      $scope.page.template=result

  $scope.goToSettings=->
    $state.go 'app.admin.sites.site.settings',{site:$scope.site.domainName}




  

