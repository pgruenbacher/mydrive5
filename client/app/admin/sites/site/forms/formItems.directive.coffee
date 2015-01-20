'use strict'

angular.module 'mydrive5App'
.directive 'formItems', (Forms,random)->
  templateUrl: 'app/admin/sites/site/forms/formItems.html'
  restrict: 'EA'
  scope:
    formItems:'='
  link: (scope, element, attrs) ->
    scope.defaults=Forms.default.fields
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
      field.options && field.options.constructor == Array

    scope.hasProp=(item,prop)->
      _.has(item,prop)

    scope.deleteOption=(parentIndex,index)->
      scope.formItems[parentIndex].options.splice(index,1)
    scope.addOption=(index,option)->
      if option.value? && option.name?
        scope.formItems[index].options.push(option)
