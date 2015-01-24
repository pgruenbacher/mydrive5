'use strict';

var _ = require('lodash');
var Subscriber = require('./subscriber.model');
var stringify = require('csv-stringify');
var generate = require('csv-generate');
var fs = require('fs');

var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership;
var extendAndSave=Common.extendAndSave;

// Gets list of subscribers from the DB.
exports.index = function(req, res) {
  Subscriber.findAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

exports.download = function(req,res){
  var generator = generate({columns: ['int', 'bool'], length: 100});
  var stringifier = stringify();
  var writeStream = fs.createWriteStream('subscribers.csv');
  
  res.setHeader('Content-disposition', 'attachment; filename=subscribers.csv');
  res.setHeader('Content-type', 'text/csv');
  writeStream.on('end', function() {
    res.end({"status":"Completed"});
  });

  generator.pipe(stringifier).pipe(writeStream).pipe(res);
};

// Gets a single subscriber from the DB.
exports.show = function(req, res) {
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new subscriber in the DB.
exports.create = function(req, res) {
  Subscriber.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

// Updates an existing subscriber in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a subscriber from the DB.
exports.destroy = function(req, res) {
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
