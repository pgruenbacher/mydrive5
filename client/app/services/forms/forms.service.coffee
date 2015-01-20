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
    ]

  default:
    title:'example Form'
    fields:[
      {
        id:1
        type:'checkbox'
        name:'checkbox'
        label:'checkbox demo'
        required:true
      }
      {
        id:2
        type:'options'
        name:'asdfff'
        label:'options demo'
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
        label:'date example'
        format:'MM.dd.YYYY'
        placeholder:'pibck date'
      }
      {
        id:4
        type:'textarea'
        name:'asbb'
        label:'text example'
        required:true
        placeholder:'adsflkj placehold'
      }
      {
        id:5
        type:'textfield'
        name:'ab'
        label:'text example'
        required:true
        placeholder:'adsflkj placehold'
      }
      {
        id:6
        type:'choices'
        name:'choicefield'
        label:'multiple choice example'
        required:true
        options:[
          {name:'choice A',value:'A'}
          {name:'choice B',value:'B'}
          {name:'choice C',value:'C'}
          {name:'choice D',value:'D'}

        ]
      }

    ]
