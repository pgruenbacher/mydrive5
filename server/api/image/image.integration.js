'use strict';

var app = require('../../app');
var request = require('supertest');

describe('Image API:', function() {

  describe('GET /api/images', function() {
    var images;

    beforeEach(function(done) {
      request(app)
        .get('/api/images')
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          images = res.body;
          done();
        });
    });

    it('should respond with JSON array', function() {
      images.should.be.instanceOf(Array);
    });

  });

});
