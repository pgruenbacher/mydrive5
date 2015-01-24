'use strict';

var app = require('../../app');
var request = require('supertest');

var newForm;

describe('Form API:', function() {

  describe('GET /api/forms', function() {
    var forms;

    beforeEach(function(done) {
      request(app)
        .get('/api/forms')
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          forms = res.body;
          done();
        });
    });

    it('should respond with JSON array', function() {
      forms.should.be.instanceOf(Array);
    });

  });

  describe('POST /api/forms', function() {
    beforeEach(function(done) {
      request(app)
        .post('/api/forms')
        .send({
          name: 'New Form',
          info: 'This is the brand new form!!!'
        })
        .expect(201)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          newForm = res.body;
          done();
        });
    });

    it('should respond with the newly created form', function() {
      newForm.name.should.equal('New Form');
      newForm.info.should.equal('This is the brand new form!!!');
    });

  });

  describe('GET /api/forms/:id', function() {
    var form;

    beforeEach(function(done) {
      request(app)
        .get('/api/forms/' + newForm._id)
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          form = res.body;
          done();
        });
    });

    afterEach(function() {
      form = {};
    });

    it('should respond with the requested form', function() {
      form.name.should.equal('New Form');
      form.info.should.equal('This is the brand new form!!!');
    });

  });

  describe('PUT /api/forms/:id', function() {
    var updatedForm

    beforeEach(function(done) {
      request(app)
        .put('/api/forms/' + newForm._id)
        .send({
          name: 'Updated Form',
          info: 'This is the updated form!!!'
        })
        .expect(200)
        .expect('Content-Type', /json/)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          updatedForm = res.body;
          done();
        });
    });

    afterEach(function() {
      updatedForm = {};
    });

    it('should respond with the updated form', function() {
      updatedForm.name.should.equal('Updated Form');
      updatedForm.info.should.equal('This is the updated form!!!');
    });

  });

  describe('DELETE /api/forms/:id', function() {

    it('should respond with 204 on successful removal', function(done) {
      request(app)
        .delete('/api/forms/' + newForm._id)
        .expect(204)
        .end(function(err, res) {
          if (err) {
            return done(err);
          }
          done();
        });
    });

    it('should respond with 404 when form does not exsist', function(done) {
      request(app)
        .delete('/api/forms/' + newForm._id)
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
