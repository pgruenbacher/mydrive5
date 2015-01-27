'use strict'

angular.module 'mydrive5App'
.factory 'Forms', ($http,$q)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  # Creates record, not upload!
  forms=[]
  all:()->
    $http.get 'api/forms'
  create:(data)->
    $http.post 'api/forms',data
  update:(id,data)->
    $http.put 'api/forms/'+id,data
  get:(id)->
    $http.get 'api/forms/'+id
  remove:(id)->
    $http.delete 'api/forms/'+id
  cacheCall:()->
    if forms.length
      deferred=$q.defer()
      deferred.resolve({data:forms})
      return deferred.promise
    else
      @all().success (data)->
        forms=data
  openFormModal:(form)->

  submitActions:[
    {
      description:'simply save form, then close'
      type:'simple'
    },{
      description:'save and navigate to different page'
      type:'navigate'
    },{
      description:'save and go to another new form'
      type:'nextForm'
    },{
      description:'save and go to checkout page'
      type:'checkout'
    }
  ]

  types:[
    'checkbox'
    'options'
    'date'
    'textfield'
    'textarea'
  ]
  registration:
    title:'Register for Event'
    fields:[
      {
        id:0
        name:'name'
        label:'your name'
        required:true
        type:'textfield'
      }
      {
        id:1
        name:'street'
        label:'street address'
        required:true
        type:'textfield'
      }
      {
        id:2
        name:'city'
        label:'city'
        required:true
        type:'textfield'
      }
      {
        id:3
        name:'state'
        type:'states'
        label:'state'
        required:true
        placeholder:'--state--'
      }
      {
        id:4
        name:'zip'
        type:'number'
        minlength:5
        maxlength:10
        label:'zip code'
      }
      {
        id:5
        name:'agree'
        type:'checkbox'
        label:'I have agreed to the terms and conditions'
        required:true
      }
      {
        id:6
        name:'available'
        type:'date'
        label:'Availability'
        required:true
      }
    ]

  order:
    title: 'order Form'
    fields:[
      {
        id:1
        type:'number'
        name:'tickets'
        label:'enter # of tickerts'
        required:true
      }
      {
        id:2
        type:'textfield'
        name:'street'
        label:'street address'
        required:true
        description:'delivery address'
      }
      {
        id:3
        type:'textfield'
        name:'city'
        label:'city'
        required:true
      }
    ]










  default:
    title:'example Form'
    fields:[
      {
        id:1
        type:'checkbox'
        name:'checkbox'
        label:'checkbox'
        required:true
        icon:'fa-check-square-o'
      }
      {
        id:2
        type:'options'
        name:'options'
        label:'options dropdown'
        selects:[
          {name:'option1',value:'duty1'}
          {name:'option2',value:'duty2'}
        ]
        required:true
        placeholder:'pick option'
        icon:'fa-caret-square-o-down'
      }
      {
        id:'asdf'
        type:'phoneNumber'
        label:'phone number'
        name:'phone'
        required:true
        icon:'fa-phone'
      }
      {
        id:3
        type:'date'
        name:'datepick'
        date:new Date()
        label:'date picker'
        format:'MM.dd.YYYY'
        placeholder:'pick a date'
        icon:'fa-calendar'
      }
      {
        id:4
        type:'textarea'
        name:'textarea'
        label:'text box'
        required:true
        maxlength:100
        minlength:20
      }
      {
        id:5
        type:'textfield'
        name:'textfield'
        label:'text field'
        required:true
        maxlength:20
        minlength:4
      }
      {
        id:6
        type:'choices'
        name:'choicefield'
        label:'multiple choice'
        required:true
        selects:[
          {name:'choice A',value:'A'}
          {name:'choice B',value:'B'}
          {name:'choice C',value:'C'}
          {name:'choice D',value:'D'}

        ]
      }
      {
        id:7
        type:'states'
        name:'states'
        required:true
        label:'state'
      }
      {
        id:8
        type:'number'
        name:'number'
        required:true
        label:'number'
        minlength:5
        maxlength:10
      }

    ]
