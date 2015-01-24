'use strict';

var app = require('../../app');
var request = require('supertest');

var newCustom;

describe('Custom API:', function() {

  describe('GET /api/data/customs', function() {
    var customs;

    beforeEach(function(done) {
      request(app)
        .get('/api/data/customs')
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          customs = res.body;
          done();
        });
    });

    it('should respond with JSON array', function() {
      customs.should.be.instanceOf(Array);
    });

  });

  describe('POST /api/data/customs', function() {
    beforeEach(function(done) {
      request(app)
        .post('/api/data/customs')
        .send({
          name: 'New Custom',
          info: 'This is the brand new custom!!!'
        })
        .expect(201)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          newCustom = res.body;
          done();
        });
    });

    it('should respond with the newly created custom', function() {
      newCustom.name.should.equal('New Custom');
      newCustom.info.should.equal('This is the brand new custom!!!');
    });

  });

  describe('GET /api/data/customs/:id', function() {
    var custom;

    beforeEach(function(done) {
      request(app)
        .get('/api/data/customs/' + newCustom._id)
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          custom = res.body;
          done();
        });
    });

    afterEach(function() {
      custom = {};
    });

    it('should respond with the requested custom', function() {
      custom.name.should.equal('New Custom');
      custom.info.should.equal('This is the brand new custom!!!');
    });

  });

  describe('PUT /api/data/customs/:id', function() {
    var updatedCustom

    beforeEach(function(done) {
      request(app)
        .put('/api/data/customs/' + newCustom._id)
        .send({
          name: 'Updated Custom',
          info: 'This is the updated custom!!!'
        })
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          updatedCustom = res.body;
          done();
        });
    });

    afterEach(function() {
      updatedCustom = {};
    });

    it('should respond with the updated custom', function() {
      updatedCustom.name.should.equal('Updated Custom');
      updatedCustom.info.should.equal('This is the updated custom!!!');
    });

  });

  describe('DELETE /api/data/customs/:id', function() {

    it('should respond with 204 on successful removal', function(done) {
      request(app)
        .delete('/api/data/customs/' + newCustom._id)
        .expect(204)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          done();
        });
    });

    it('should respond with 404 when custom does not exsist', function(done) {
      request(app)
        .delete('/api/data/customs/' + newCustom._id)
        .expect(404)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          done();
        });
    });

  });

});
