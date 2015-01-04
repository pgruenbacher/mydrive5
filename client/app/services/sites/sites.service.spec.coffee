'use strict'

describe 'Service: sites', ->

  # load the service's module
  beforeEach module 'mydrive5App'

  # instantiate service
  sites = undefined
  beforeEach inject (_sites_) ->
    sites = _sites_

  it 'should do something', ->
    expect(!!sites).toBe true
