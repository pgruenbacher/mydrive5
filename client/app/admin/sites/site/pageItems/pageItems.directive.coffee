'use strict'

angular.module 'mydrive5App'
.directive 'pageItems', ->
  templateUrl: 'app/admin/sites/site/pageItems/pageItems.html'
  restrict: 'EA'
  scope:
    menuItems:'='
  link: (scope, element, attrs) ->
    
  controller:($scope)->
    $scope.addMenu = (title,form)->
      if $scope.menuItems.length > 6
        window.alert 'You can\'t add more than 10 groups!'
        return
      $scope.menuItems.push
        title: title
        sub: []
    $scope.addSubMenu=(index,title)->
      $scope.menuItems[index].subAdding=false
      $scope.menuItems[index].sub.push
        title: title
        sub: []
    $scope.editMenu = (item)->
      item.editing = true
    $scope.closeMenu = (item)->
      item.editing = false
    $scope.removeSubMenu = (parentIndex, index)->
      if (window.confirm('Are you sure to remove this page?'))
        $scope.menuItems[parentIndex].sub.splice(index, 1)[0]
    $scope.removeMenu = (index)->
      if (window.confirm('Are you sure to remove this menu?'))
        $scope.menuItems.splice(index,1);
    $scope.options = 
      accept: (sourceNode, destNodes, destIndex)->
        source = sourceNode.$modelValue;
        destinationType = destNodes.$element.attr('data-type');
        if source.sub && destinationType == 'subMenuItem'
          return false
        return true