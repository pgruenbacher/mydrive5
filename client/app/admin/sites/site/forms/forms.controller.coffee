'use strict'

angular.module 'mydrive5App'
.controller 'FormsCtrl', ($scope,site,Sites,Forms,forms) ->
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
        console.log response.data
        $scope.form=response.data[0]
        # reinit()
    else
      Forms.create(form)
      .then (response)->
        $scope.form=response.data[0]
        # reinit()

  # reinit=()->
  #   Forms.all().then (response)->
  #     $scope.forms=response.data


  $scope.newField={}
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
