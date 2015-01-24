'use strict'

angular.module 'mydrive5App'
.directive 'palettePicker', ($document,exitclick)->
  templateUrl: 'components/palette-picker/palettePicker.html'
  restrict: 'E'
  scope:
    choice:'='
  link: (scope, element, attrs) ->
    scope.pickerVisible=false
    scope.togglePicker = ->
      scope.pickerVisible=!scope.pickerVisible
    scope.choosePalette=(item)->
      scope.choice=item

    exitclick.set scope,element,->
      scope.pickerVisible=false

    scope.choices=[
      [
        [204,95,67]
        [210,66,91]
        [194,124,107]
        [225,63,41]
      ],
      [
        [220,175,107]
        [225,164,47]
        [148,107,56]
        [205,128,54]
      ]
    ]

    for choice in scope.choices
      for color in choice
        color.string='rgb('+color[0]+','+color[1]+','+color[2]+')'

    scope.choice=scope.choices[0]


