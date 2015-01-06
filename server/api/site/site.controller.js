'use strict';

var _ = require('lodash');
var Site = require('./site.model');

var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;

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
  // So hacky update
  // Site.findOneAndUpdate({
  //   _id:req.params._id
  // },req.body,function(site){
  //   return res.json(site);
  // });

  Site.updateAsync({
    _id:req.params.id,
    'menuItems._id':req.body.id
  },req.body)
  .spread(function(a,b){
    console.log(a,b);
    res.json(a);
  })
  .catch(handleError(res));

  // Site.findByIdAsync(req.params.id)
  //   .then(handleEntityNotFound(res))
  //   .then(saveUpdates(req.body))
  //   .then(responseWithResult(res))
  //   .catch(handleError(res));
};

exports.setSub = function(req,res){
  var data=req.body;
  Site.findOneAsync({_id:req.params.id})
  .then(handleEntityNotFound(res))
  .then(function(site){
    site.menuItems[data.grandParentIndex].sub[data.parentIndex].template=req.body.template;
    site.saveAsync()
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
  })
  .catch(handleError(res));
};
exports.setMenu = function(req,res){
  var data=req.body;
  Site.findOneAsync({_id:req.params.id})
  .then(handleEntityNotFound(res))
  .then(function(site){
    site.menuItems[data.parentIndex].template=req.body.template;
    site.saveAsync()
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
  })
  .catch(handleError(res));
};

// Deletes a site from the DB.
exports.destroy = function(req, res) {
  Site.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
