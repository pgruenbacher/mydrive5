'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var postCtrlStub = {
  index: 'postCtrl.index'
};

var routerStub = {
  get: sinon.spy()
};

// require the index with our stubbed out modules
var postIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './post.controller': postCtrlStub
});

describe('Post API Router:', function() {

  it('should return an express router instance', function() {
    postIndex.should.equal(routerStub);
  });

  describe('GET /api/posts', function() {

    it('should route to post.controller.index', function() {
      routerStub.get
                .withArgs('/', 'postCtrl.index')
                .should.have.been.calledOnce;
    });

  });

});
