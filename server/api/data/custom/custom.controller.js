'use strict';

var _ = require('lodash');
var Custom = require('./custom.model');


var Common = require('../../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership;
var extendAndSave=Common.extendAndSave;

// Gets list of customs from the DB.
exports.index = function(req, res) {
  Custom.findAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Gets a single custom from the DB.
exports.show = function(req, res) {
  Custom.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new custom in the DB.
exports.create = function(req, res) {
  Custom.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

// Updates an existing custom in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Custom.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a custom from the DB.
exports.destroy = function(req, res) {
  Custom.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
