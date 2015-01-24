'use strict'

angular.module 'mydrive5App'

.controller 'formItemModalCtrl',($scope,Forms)->
  $scope.fields=Forms.default.fields

.directive 'formItems', (Forms,random,exitclick,$modal)->
  templateUrl: 'app/admin/sites/site/forms/formItems.html'
  restrict: 'EA'
  scope:
    formItems:'='
    newField:'='
  link: (scope, element, attrs) ->
    console.log Forms.default.fields
    scope.defaults=Forms.default.fields
    scope.fieldEditing={}
    exitclick.set scope, element, ->
      scope.fieldEditing={}
    scope.addField = (name,field)->
      for item in scope.formItems
        if name == item.name
          window.alert 'you cannot have duplicate field names! >' + name
          return;
      if scope.formItems.length > 13
        window.alert 'You can\'t add more than 13 fields!'
        return
      field.name=name
      field.id=random.makeId(6)
      scope.formItems.push field
    scope.removeField = (index)->
      scope.formItems.splice(index,1);

    scope.hasOptions=(field)->
      field.selects && field.selects.constructor == Array

    scope.hasProp=(item,prop)->
      _.has(item,prop)

    scope.deleteOption=(parentIndex,index)->
      scope.formItems[parentIndex].selects.splice(index,1)
    scope.addOption=(index,option)->
      if option.value? && option.name?
        scope.formItems[index].selects.push(option)


    scope.chooseType=()->
      modalInstance=$modal.open
        controller:'formItemModalCtrl'
        templateUrl:'app/admin/sites/site/forms/formItemsModal.html'
        size:'lg'

      modalInstance.result.then (result)->
        scope.newField.data=result

