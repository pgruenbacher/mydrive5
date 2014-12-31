'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var imageCtrlStub = {
  index: 'imageCtrl.index'
};

var routerStub = {
  get: sinon.spy()
};

// require the index with our stubbed out modules
var imageIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './image.controller': imageCtrlStub
});

describe('Image API Router:', function() {

  it('should return an express router instance', function() {
    imageIndex.should.equal(routerStub);
  });

  describe('GET /api/images', function() {

    it('should route to image.controller.index', function() {
      routerStub.get
                .withArgs('/', 'imageCtrl.index')
                .should.have.been.calledOnce;
    });

  });

});
