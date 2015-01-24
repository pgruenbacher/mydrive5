'use strict';

var proxyquire = require('proxyquire').noPreserveCache();

var participantCtrlStub = {
  index: 'participantCtrl.index',
  show: 'participantCtrl.show',
  create: 'participantCtrl.create',
  update: 'participantCtrl.update',
  destroy: 'participantCtrl.destroy'
};

var routerStub = {
  get: sinon.spy(),
  put: sinon.spy(),
  patch: sinon.spy(),
  post: sinon.spy(),
  delete: sinon.spy()
};

// require the index with our stubbed out modules
var participantIndex = proxyquire('./index.js', {
  'express': {
    Router: function() {
      return routerStub;
    }
  },
  './participant.controller': participantCtrlStub
});

describe('Participant API Router:', function() {

  it('should return an express router instance', function() {
    participantIndex.should.equal(routerStub);
  });

  describe('GET /api/data/participants', function() {

    it('should route to participant.controller.index', function() {
      routerStub.get
                .withArgs('/', 'participantCtrl.index')
                .should.have.been.calledOnce;
    });

  });

  describe('GET /api/data/participants/:id', function() {

    it('should route to participant.controller.show', function() {
      routerStub.get
                .withArgs('/:id', 'participantCtrl.show')
                .should.have.been.calledOnce;
    });

  });

  describe('POST /api/data/participants', function() {

    it('should route to participant.controller.create', function() {
      routerStub.post
                .withArgs('/', 'participantCtrl.create')
                .should.have.been.calledOnce;
    });

  });

  describe('PUT /api/data/participants/:id', function() {

    it('should route to participant.controller.update', function() {
      routerStub.put
                .withArgs('/:id', 'participantCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('PATCH /api/data/participants/:id', function() {

    it('should route to participant.controller.update', function() {
      routerStub.patch
                .withArgs('/:id', 'participantCtrl.update')
                .should.have.been.calledOnce;
    });

  });

  describe('DELETE /api/data/participants/:id', function() {

    it('should route to participant.controller.destroy', function() {
      routerStub.delete
                .withArgs('/:id', 'participantCtrl.destroy')
                .should.have.been.calledOnce;
    });

  });

});
