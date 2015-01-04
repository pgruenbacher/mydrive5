'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var siteCtrlStub = {
  index: 'siteCtrl.index',
  show: 'siteCtrl.show',
  create: 'siteCtrl.create',
  update: 'siteCtrl.update',
  destroy: 'siteCtrl.destroy'
};

var routerStub = {
  get: sinon.spy(),
  put: sinon.spy(),
  patch: sinon.spy(),
  post: sinon.spy(),
  delete: sinon.spy()
};

// require the index with our stubbed out modules
var siteIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './site.controller': siteCtrlStub
});

describe('Site API Router:', function() {

  it('should return an express router instance', function() {
    siteIndex.should.equal(routerStub);
  });

  describe('GET /api/sites', function() {

    it('should route to site.controller.index', function() {
      routerStub.get
                .withArgs('/', 'siteCtrl.index')
                .should.have.been.calledOnce;
    });

  });

  describe('GET /api/sites/:id', function() {

    it('should route to site.controller.show', function() {
      routerStub.get
                .withArgs('/:id', 'siteCtrl.show')
                .should.have.been.calledOnce;
    });

  });

  describe('POST /api/sites', function() {

    it('should route to site.controller.create', function() {
      routerStub.post
                .withArgs('/', 'siteCtrl.create')
                .should.have.been.calledOnce;
    });

  });

  describe('PUT /api/sites/:id', function() {

    it('should route to site.controller.update', function() {
      routerStub.put
                .withArgs('/:id', 'siteCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('PATCH /api/sites/:id', function() {

    it('should route to site.controller.update', function() {
      routerStub.patch
                .withArgs('/:id', 'siteCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('DELETE /api/sites/:id', function() {

    it('should route to site.controller.destroy', function() {
      routerStub.delete
                .withArgs('/:id', 'siteCtrl.destroy')
                .should.have.been.calledOnce;
    });

  });

});
