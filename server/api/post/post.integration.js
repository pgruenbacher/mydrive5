'use strict';

var app = require('../../app');
var request = require('supertest');

describe('Post API:', function() {

  describe('GET /api/posts', function() {
    var posts;

    beforeEach(function(done) {
      request(app)
        .get('/api/posts')
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          posts = res.body;
          done();
        });
    });

    it('should respond with JSON array', function() {
      posts.should.be.instanceOf(Array);
    });

  });

});
