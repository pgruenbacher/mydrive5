'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var customCtrlStub = {
  index: 'customCtrl.index',
  show: 'customCtrl.show',
  create: 'customCtrl.create',
  update: 'customCtrl.update',
  destroy: 'customCtrl.destroy'
};

var routerStub = {
  get: sinon.spy(),
  put: sinon.spy(),
  patch: sinon.spy(),
  post: sinon.spy(),
  delete: sinon.spy()
};

// require the index with our stubbed out modules
var customIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './custom.controller': customCtrlStub
});

describe('Custom API Router:', function() {

  it('should return an express router instance', function() {
    customIndex.should.equal(routerStub);
  });

  describe('GET /api/data/customs', function() {

    it('should route to custom.controller.index', function() {
      routerStub.get
                .withArgs('/', 'customCtrl.index')
                .should.have.been.calledOnce;
    });

  });

  describe('GET /api/data/customs/:id', function() {

    it('should route to custom.controller.show', function() {
      routerStub.get
                .withArgs('/:id', 'customCtrl.show')
                .should.have.been.calledOnce;
    });

  });

  describe('POST /api/data/customs', function() {

    it('should route to custom.controller.create', function() {
      routerStub.post
                .withArgs('/', 'customCtrl.create')
                .should.have.been.calledOnce;
    });

  });

  describe('PUT /api/data/customs/:id', function() {

    it('should route to custom.controller.update', function() {
      routerStub.put
                .withArgs('/:id', 'customCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('PATCH /api/data/customs/:id', function() {

    it('should route to custom.controller.update', function() {
      routerStub.patch
                .withArgs('/:id', 'customCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('DELETE /api/data/customs/:id', function() {

    it('should route to custom.controller.destroy', function() {
      routerStub.delete
                .withArgs('/:id', 'customCtrl.destroy')
                .should.have.been.calledOnce;
    });

  });

});
