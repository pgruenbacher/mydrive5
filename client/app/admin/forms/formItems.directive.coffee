'use strict'

angular.module 'mydrive5App'

.controller 'formItemModalCtrl',($scope,Forms)->
  $scope.fields=Forms.default.fields
  $scope.selected={field:{}}

.directive 'formItems', (Forms,random,exitclick,$modal)->
  templateUrl: 'app/admin/forms/formItems.html'
  restrict: 'EA'
  scope:
    formItems:'='
  link: (scope, element, attrs) ->
    scope.defaults=Forms.default.fields
    scope.fieldEditing={}
    exitclick.set scope, element, ->
      scope.fieldEditing={}
    scope.addField = (field)->
      for item in scope.formItems
        if name == item.name
          window.alert 'you cannot have duplicate field names! >' + name
          return;
      if scope.formItems.length > 13
        window.alert 'You can\'t add more than 13 fields!'
        return
      field.id=random.makeId(6)
      scope.formItems.push field

    scope.removeField = (index)->
      scope.formItems.splice(index,1);

    scope.newField=()->
      modalInstance=$modal.open
        controller:'formItemModalCtrl'
        templateUrl:'app/admin/forms/formItemsModal.html'
        size:'lg'

      modalInstance.result.then (result)->
        scope.addField(result)

.directive 'formOptions', (Forms,random,exitclick,$modal)->
  templateUrl: 'app/admin/forms/formOptions.html'
  restrict: 'EA'
  scope:
    field:'='
  link: (scope, element, attrs) ->

    scope.hasOptions=(field)->
      field.selects && field.selects.constructor == Array

    scope.hasProp=(item,prop)->
      _.has(item,prop)

    scope.deleteOption=(parentIndex,index)->
      scope.field.selects.splice(index,1)

    scope.addOption=(index,option)->
      if option.value? && option.name?
        scope.field.selects.push(option)