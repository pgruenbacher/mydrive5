'use strict';

var _ = require('lodash');
var Site = require('./site.model');

function handleError(res, statusCode) {
  statusCode = statusCode || 500;
  return function(err) {
    console.log(err);
    res.send(statusCode, err);
  };
}

function responseWithResult(res, statusCode) {
  statusCode = statusCode || 200;
  return function(entity) {
    if (entity) {
      return res.json(statusCode, entity);
    }
  };
}

function handleEntityNotFound(res) {
  return function(entity) {
    if (!entity) {
      res.send(404);
      return null;
    }
    return entity;
  };
}

function saveUpdates(updates) {
  return function(entity) {
    var updated = _.merge(entity, updates);
    return updated.saveAsync()
      .spread(function(updated) {
        return updated;
      });
  };
}

function removeEntity(res) {
  return function(entity) {
    if (entity) {
      return entity.removeAsync()
        .then(function() {
          return res.send(204);
        });
    }
  };
}

// Gets list of sites from the DB.
exports.index = function(req, res) {
  Site.findAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Gets a single site from the DB.
exports.show = function(req, res) {
  Site.findAsync({domainName:req.params.domainName}).limit(1)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new site in the DB.
exports.create = function(req, res) {
  console.log(req);
  Site.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

exports.find = function(req,res){
  if(req.query.domainName){
    Site.find({domainName:req.query.domainName}).limit(1)
    .execAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
  }else{
    handleError(res);
  }
};

// Updates an existing site in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Site.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a site from the DB.
exports.destroy = function(req, res) {
  Site.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
