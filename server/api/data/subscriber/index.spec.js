'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var subscriberCtrlStub = {
  index: 'subscriberCtrl.index',
  show: 'subscriberCtrl.show',
  create: 'subscriberCtrl.create',
  update: 'subscriberCtrl.update',
  destroy: 'subscriberCtrl.destroy'
};

var routerStub = {
  get: sinon.spy(),
  put: sinon.spy(),
  patch: sinon.spy(),
  post: sinon.spy(),
  delete: sinon.spy()
};

// require the index with our stubbed out modules
var subscriberIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './subscriber.controller': subscriberCtrlStub
});

describe('Subscriber API Router:', function() {

  it('should return an express router instance', function() {
    subscriberIndex.should.equal(routerStub);
  });

  describe('GET /api/data/subscribers', function() {

    it('should route to subscriber.controller.index', function() {
      routerStub.get
                .withArgs('/', 'subscriberCtrl.index')
                .should.have.been.calledOnce;
    });

  });

  describe('GET /api/data/subscribers/:id', function() {

    it('should route to subscriber.controller.show', function() {
      routerStub.get
                .withArgs('/:id', 'subscriberCtrl.show')
                .should.have.been.calledOnce;
    });

  });

  describe('POST /api/data/subscribers', function() {

    it('should route to subscriber.controller.create', function() {
      routerStub.post
                .withArgs('/', 'subscriberCtrl.create')
                .should.have.been.calledOnce;
    });

  });

  describe('PUT /api/data/subscribers/:id', function() {

    it('should route to subscriber.controller.update', function() {
      routerStub.put
                .withArgs('/:id', 'subscriberCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('PATCH /api/data/subscribers/:id', function() {

    it('should route to subscriber.controller.update', function() {
      routerStub.patch
                .withArgs('/:id', 'subscriberCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('DELETE /api/data/subscribers/:id', function() {

    it('should route to subscriber.controller.destroy', function() {
      routerStub.delete
                .withArgs('/:id', 'subscriberCtrl.destroy')
                .should.have.been.calledOnce;
    });

  });

});
