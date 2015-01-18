'use strict';

var _ = require('lodash');
var Site = require('./site.model');

var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership

// Gets list of sites from the DB.
exports.index = function(req, res) {
  Site.find({'user._id':req.user._id}).select('domainName siteName')
    .execAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Gets a single site from the DB.
exports.show = function(req, res) {
  Site.find({domainName:req.params.domainName}).limit(1)
    .execAsync()
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new site in the DB.
exports.create = function(req, res) {
  req.body.user={_id:req.user._id};
  Site.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

exports.find = function(req,res){
  if(req.query.domainName){
    Site.find({domainName:req.query.domainName}).select('domainName').limit(1)
    .execAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
  }else{
    handleError(res);
  }
};

// Updates an existing site in the DB.
exports.update = function(req, res) {
  var data = req.body;
  Site.findOneAsync({_id:req.params.id})
  .then(handleEntityNotFound(res))
  .then(verifySiteOwnership(res,req.user._id))
  .then(function(site){
    _.extend(site,req.body)
    site.saveAsync()
    .then(responseWithResult(res,201))
    .catch(handleError(res));
  })
  .catch(handleError(res));
};

exports.setHome = function(req,res){
  var data = req.body;
  Site.findOneAsync({_id:req.params.id})
  .then(handleEntityNotFound(res))
  .then(verifySiteOwnership(res,req.user._id))
  .then(function(site){
    site.homePage.template=req.body.template;
    site.saveAsync()
    .then(responseWithResult(res,201))
    .catch(handleError(res));
  })
  .catch(handleError(res));
};

exports.setSub = function(req,res){
  var data=req.body;
  Site.findOneAsync({_id:req.params.id})
  .then(handleEntityNotFound(res))
  .then(verifySiteOwnership(res,req.user._id))
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
  .then(verifySiteOwnership(res,req.user._id))
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
