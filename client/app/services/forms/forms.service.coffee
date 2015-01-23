'use strict'

angular.module 'mydrive5App'
.factory 'Forms', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  # Creates record, not upload!
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
      }
      {
        id:4
        name:'agree'
        type:'checkbox'
        label:'I have agreed to the terms and conditions'
        required:true
      }
      {
        id:5
        name:'available'
        type:'date'
        label:'Availability'
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
      }
      {
        id:2
        type:'options'
        name:'options'
        label:'options dropdown'
        options:[
          {name:'option1',value:'duty1'}
          {name:'option2',value:'duty2'}
        ]
        required:true
        placeholder:'pick option'
      }
      {
        id:3
        type:'date'
        name:'datepick'
        date:new Date()
        label:'date picker'
        format:'MM.dd.YYYY'
        placeholder:'pick a date'
      }
      {
        id:4
        type:'textarea'
        name:'textarea'
        label:'text box'
        required:true
        maxlength:100
        minlength:20
        placeholder:'text field'
      }
      {
        id:5
        type:'textfield'
        name:'textfield'
        label:'text field'
        required:true
        maxlength:20
        minlength:4
        placeholder:'text area'
      }
      {
        id:6
        type:'choices'
        name:'choicefield'
        label:'multiple choice'
        required:true
        options:[
          {name:'choice A',value:'A'}
          {name:'choice B',value:'B'}
          {name:'choice C',value:'C'}
          {name:'choice D',value:'D'}

        ]
      }

    ]
