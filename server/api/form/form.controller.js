'use strict';

var _ = require('lodash');
var Form = require('./form.model');


var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership;
var extendAndSave=Common.extendAndSave;

// Gets list of forms from the DB.
exports.index = function(req, res) {
  Form.find({'user._id':req.user._id})
    .execAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Gets a single form from the DB.
exports.show = function(req, res) {
  Form.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new form in the DB.
exports.create = function(req, res) {
  req.body.user={_id:req.user._id};
  Form.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

// Updates an existing form in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Form.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(extendAndSave(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a form from the DB.
exports.destroy = function(req, res) {
  Form.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
