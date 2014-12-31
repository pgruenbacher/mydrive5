'use strict'

describe 'Filter: filters', ->

  # load the filter's module
  beforeEach module 'mydrive5App'

  # initialize a new instance of the filter before each test
  filters = undefined
  beforeEach inject ($filter) ->
    filters = $filter 'filters'

  it 'should return the input prefixed with \'filters filter:\'', ->
    text = 'angularjs'
    expect(filters text).toBe 'filters filter: ' + text
