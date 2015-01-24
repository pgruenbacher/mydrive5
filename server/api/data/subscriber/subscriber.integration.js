'use strict';

var app = require('../../app');
var request = require('supertest');

var newSubscriber;

describe('Subscriber API:', function() {

  describe('GET /api/data/subscribers', function() {
    var subscribers;

    beforeEach(function(done) {
      request(app)
        .get('/api/data/subscribers')
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          subscribers = res.body;
          done();
        });
    });

    it('should respond with JSON array', function() {
      subscribers.should.be.instanceOf(Array);
    });

  });

  describe('POST /api/data/subscribers', function() {
    beforeEach(function(done) {
      request(app)
        .post('/api/data/subscribers')
        .send({
          name: 'New Subscriber',
          info: 'This is the brand new subscriber!!!'
        })
        .expect(201)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          newSubscriber = res.body;
          done();
        });
    });

    it('should respond with the newly created subscriber', function() {
      newSubscriber.name.should.equal('New Subscriber');
      newSubscriber.info.should.equal('This is the brand new subscriber!!!');
    });

  });

  describe('GET /api/data/subscribers/:id', function() {
    var subscriber;

    beforeEach(function(done) {
      request(app)
        .get('/api/data/subscribers/' + newSubscriber._id)
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          subscriber = res.body;
          done();
        });
    });

    afterEach(function() {
      subscriber = {};
    });

    it('should respond with the requested subscriber', function() {
      subscriber.name.should.equal('New Subscriber');
      subscriber.info.should.equal('This is the brand new subscriber!!!');
    });

  });

  describe('PUT /api/data/subscribers/:id', function() {
    var updatedSubscriber

    beforeEach(function(done) {
      request(app)
        .put('/api/data/subscribers/' + newSubscriber._id)
        .send({
          name: 'Updated Subscriber',
          info: 'This is the updated subscriber!!!'
        })
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          updatedSubscriber = res.body;
          done();
        });
    });

    afterEach(function() {
      updatedSubscriber = {};
    });

    it('should respond with the updated subscriber', function() {
      updatedSubscriber.name.should.equal('Updated Subscriber');
      updatedSubscriber.info.should.equal('This is the updated subscriber!!!');
    });

  });

  describe('DELETE /api/data/subscribers/:id', function() {

    it('should respond with 204 on successful removal', function(done) {
      request(app)
        .delete('/api/data/subscribers/' + newSubscriber._id)
        .expect(204)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          done();
        });
    });

    it('should respond with 404 when subscriber does not exsist', function(done) {
      request(app)
        .delete('/api/data/subscribers/' + newSubscriber._id)
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
