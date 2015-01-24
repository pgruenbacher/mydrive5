'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var formCtrlStub = {
  index: 'formCtrl.index',
  show: 'formCtrl.show',
  create: 'formCtrl.create',
  update: 'formCtrl.update',
  destroy: 'formCtrl.destroy'
};

var routerStub = {
  get: sinon.spy(),
  put: sinon.spy(),
  patch: sinon.spy(),
  post: sinon.spy(),
  delete: sinon.spy()
};

// require the index with our stubbed out modules
var formIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './form.controller': formCtrlStub
});

describe('Form API Router:', function() {

  it('should return an express router instance', function() {
    formIndex.should.equal(routerStub);
  });

  describe('GET /api/forms', function() {

    it('should route to form.controller.index', function() {
      routerStub.get
                .withArgs('/', 'formCtrl.index')
                .should.have.been.calledOnce;
    });

  });

  describe('GET /api/forms/:id', function() {

    it('should route to form.controller.show', function() {
      routerStub.get
                .withArgs('/:id', 'formCtrl.show')
                .should.have.been.calledOnce;
    });

  });

  describe('POST /api/forms', function() {

    it('should route to form.controller.create', function() {
      routerStub.post
                .withArgs('/', 'formCtrl.create')
                .should.have.been.calledOnce;
    });

  });

  describe('PUT /api/forms/:id', function() {

    it('should route to form.controller.update', function() {
      routerStub.put
                .withArgs('/:id', 'formCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('PATCH /api/forms/:id', function() {

    it('should route to form.controller.update', function() {
      routerStub.patch
                .withArgs('/:id', 'formCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('DELETE /api/forms/:id', function() {

    it('should route to form.controller.destroy', function() {
      routerStub.delete
                .withArgs('/:id', 'formCtrl.destroy')
                .should.have.been.calledOnce;
    });

  });

});
