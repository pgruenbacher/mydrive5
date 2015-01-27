'use strict'

angular.module 'mydrive5App'

.controller 'formExamplesModalCtrl', ($scope,Forms)->
  $scope.selected={form:{}}
  $scope.possible=
    [
      {title:'Custom',fields:[
        {
          type:'textfield'
          name:'example'
          label:'custom field'
          required:true
          }]}
      Forms.registration
      Forms.order
    ]


.controller 'FormsCtrl', ($scope,Forms,forms,$modal) ->
  # $scope.site=site
  # $scope.saveSite=()->
  #   console.log 'save'
  #   Sites.saveSite($scope.site._id,$scope.site)
  #   .then (response)->
  #     console.log response

  $scope.forms=forms
  $scope.editing=false
  $scope.form=
    fields:[]

  $scope.actions=Forms.submitActions
  console.log $scope.actions

  $scope.editForm=(form)->
    $scope.editing=true
    $scope.form=form

  $scope.newForm=()->
    $scope.editing=true
    $scope.form=
      fields:[]

  $scope.deleteForm=(id)->
    Forms.remove(id)
    .then (response)->
      console.log response

  $scope.saveForm=(form)->
    if form.fields.length==0
      return

    if form._id?
      Forms.update(form._id,form)
      .then (response)->
        $scope.form=response.data[0]
        reinit()
    else
      Forms.create(form)
      .then (response)->
        $scope.form=response.data
        reinit()

  reinit=()->
    Forms.all().then (response)->
      $scope.forms=response.data

  $scope.openExamples=()->
    modalInstance= $modal.open
      templateUrl:'app/admin/forms/formExamplesModal.html'
      size:'lg'
      controller:'formExamplesModalCtrl'

    modalInstance.result.then (result)->
      if result.title
        $scope.editing=true
        $scope.form=result


  $scope.newField={}
  