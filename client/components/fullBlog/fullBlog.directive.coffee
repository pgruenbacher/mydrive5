'use strict'

angular.module 'mydrive5App'
.directive 'fullBlog', ->

  ab2str=(buf)->
    return String.fromCharCode.apply(null, new Uint16Array(buf))

  templateUrl: 'components/fullBlog/fullBlog.html'
  restrict: 'EA'
  scope:
    editorOptions:'='
    blog:'='
  link: (scope, element, attrs) ->
    
  controller:($scope,Posts)->
    $scope.index=true;
    $scope.posts=[];

    Posts.all()
    .then (response)->
      $scope.posts=response.data


    $scope.openPost=(post)->
      Posts.get(post._id)
      .then (response)->
        $scope.index=false
        $scope.post=response.data
        $scope.post.html=ab2str(response.data.content)

    $scope.openIndex=()->
      $scope.index=true;
      $scope.post={};


    # pagination
    numPerPage=3
    $scope.currentPage=1
    $scope.numPages = ()->
      return Math.ceil($scope.posts.length / numPerPage)
    
    $scope.previous=()->
      if $scope.currentPage>1 then $scope.currentPage--
    $scope.next=()->
      console.log $scope.numPages()
      if $scope.currentPage<$scope.numPages() then $scope.currentPage++

    $scope.$watch 'posts+currentPage', ()->

      begin = (($scope.currentPage - 1) * numPerPage)
      end = begin + numPerPage
      $scope.filteredPosts = $scope.posts.slice(begin, end)




