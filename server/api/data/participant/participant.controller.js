'use strict';

var _ = require('lodash');
var Participant = require('./participant.model');


var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership;
var extendAndSave=Common.extendAndSave;


// Gets list of participants from the DB.
exports.index = function(req, res) {
  Participant.findAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Gets a single participant from the DB.
exports.show = function(req, res) {
  Participant.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new participant in the DB.
exports.create = function(req, res) {
  Participant.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

// Updates an existing participant in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Participant.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a participant from the DB.
exports.destroy = function(req, res) {
  Participant.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
