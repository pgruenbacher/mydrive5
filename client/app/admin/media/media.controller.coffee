'use strict'

angular.module 'mydrive5App'
.controller 'mediaCtrl', ($scope,Images,$modal,$timeout,$upload,$http,$filter) ->
  $scope.message = 'Hello'

  $scope.openUploadModal=->
    modalInstance=$modal.open 
      templateUrl:'app/admin/media/modal.html'
      size:'lg'
    # Get images if rejected or if closed
    modalInstance.result.then getMyImages, getMyImages

  $scope.images=[]
      
  $scope.myImages=[]
  $scope.splashes=[]

  $scope.selected=String
  $scope.select=(selection)->
    $scope.images=$scope[selection]
    $scope.selected=selection

  getMyImages=->
    Images.all()
    .then (response)->
      $scope.myImages = response.data     
  getMyImages()
    
  Images.splashes()
  .then (response)->
    console.log 'splash data',response
    $scope.splashes = response.data



  $scope.filteredImages=[]
  $scope.numPerPage=12
  $scope.maxPagination=8
  $scope.currentPage=1
  # For pagination of index
  # $scope.numPages = ()->
  #   return 51
    # return Math.ceil($scope.splashes.length / numPerPage) 

  $scope.$watch 'images+currentPage', ()->
    if $scope.images.length?
      begin = (($scope.currentPage - 1) * $scope.numPerPage)
      end = begin + $scope.numPerPage
      $scope.filteredImages = $scope.images.slice(begin, end)
            


.controller 'UploadCtrl', ($scope, Images, $http, $rootScope, $upload, $filter)->

  $scope.imageUploads = []

  performSave=(parsedData)->
    Images.create(parsedData).success (response)->

  performUpload=(file, i)->
    $http.get('/api/images/s3-sign?mimeType='+ file.type).success (response)->
      s3Params = response
      $scope.upload[i] = $upload.upload {
        url: 'https://mydrive5.s3.amazonaws.com/',
        method: 'POST',
        transformRequest: (data, headersGetter)->
          # Headers change here
          headers = headersGetter();
          delete headers['Authorization'];
          return data;
        data:
          'key' : 's3UploadExample/'+ Math.round(Math.random()*10000) + '$$' + file.name
          'acl' : 'public-read'
          'Content-Type' : file.type,
          'AWSAccessKeyId': s3Params.AWSAccessKeyId
          'success_action_status' : '201'
          'Policy' : s3Params.s3Policy
          'Signature' : s3Params.s3Signature
        file: file,
      }
      $scope.upload[i].then (response)->
        file.progress = parseInt(100)
        if (response.status == 201)
          data = $filter('xml2json')(response.data)
          parsedData;
          parsedData = {
            location: data.postresponse.location
            bucket: data.postresponse.bucket
            key: data.postresponse.key
            etag: data.postresponse.etag
            image:
              urlPath:data.postresponse.location
              name:file.name
              size:file.size
              type:file.type
          }
          $scope.imageUploads.push(parsedData)
          performSave(parsedData)

        else
          alert('Upload Failed');
    
      , null, (evt)->
        file.progress =  parseInt(100.0 * evt.loaded / evt.total)

  

  $scope.abort = (index)->
    $scope.upload[index].abort()
    $scope.upload[index] = null

  $scope.abortAll=()->
    for upload in $scope.upload
      upload.abort();
      upload=null

  $scope.onFileSelect = ($files)->
    $scope.files = $files
    $scope.upload = []
    i=0
    for file in $files
      file.progress = parseInt(0)
      performUpload(file,i)
      i++
  













  # uploader=$scope.uploader=new FileUploader {
  #   url:'/api/asd'
  # }
  # uploader.filters.push {
  #   name: 'customFilter'
  #   fn: (item,options)->
  #     this.queue.length<10
  #   removeAfterUpload: true
  # }

  #CALLBACKS

  # uploader.onWhenAddingFileFailed (item, filter, options)->
  #   console.log 'onWhenAddingFileFailed', item, filter, options
  
  # uploader.onAfterAddingFile = (fileItem)->
  #   console.log 'file',fileItem
  #   $http.get('/api/images/s3-sign',params:{s3ObjectName:'asdfasdf.jpg',mimeType:'image/jpeg'}).success (response)->
  #     console.log response
  #     fileItem.url='https://mydrive5.s3.amazonaws.com/'
  #     name=Math.round(Math.random()*10000) + '$$' + fileItem.file.name
  #     fileItem.formData={
  #       'key' : 's3UploadExample/'+ name,
  #       'acl' : 'public-read',
  #       'Content-Type' : fileItem.file.type,
  #       'AWSAccessKeyId': response.AWSAccessKeyId,
  #       'success_action_status' : '201',
  #       'Policy' : response.s3Policy,
  #       'Signature' : response.s3Signature
  #     }
  #     fileItem.alias=name

  # uploader.onAfterAddingAll = (addedFileItems)->
  # uploader.onBeforeUploadItem = (item) ->

  # uploader.onProgressItem = (fileItem, progress)->
  # uploader.onProgressAll = (progress) ->
  # uploader.onSuccessItem = (fileItem, response, status, headers)->
  # uploader.onErrorItem = (fileItem, response, status, headers) ->
  # uploader.onCancelItem = (fileItem, response, status, headers) ->
  # # uploader.onCompleteItem = (fileItem, response, status, headers)->
  # #    console.log(fileItem._file.name);

  # #    CRUD.image.create({url: fileItem._file.name}, function(response) {
  # #     console.log(response);
  # #    });
  # uploader.onCompleteAll = ()->
    # CRUD.image.find {}, (response)->
    #   if !response.error
    #     allImages = response.response
    #     $rootScope.images = []
    #     $rootScope.images.push allImages