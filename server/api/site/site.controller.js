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
    console.log
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

function findMenuItem(site,id,object){
  console.log('id',typeof id);
  for(var i=0;i<site.menuItems.length; i++){
    console.log(site.menuItems[i]._id,typeof site.menuItems[i]._id);
    if(site.menuItems[i]._id.equals(id)){
      console.log('return');
      site.menuItems[i]=object;
      return site;
    }
    for(var j=0; j<site.menuItems[i].sub.length; j++){
      console.log(site.menuItems[i].sub[j]._id,site.menuItems[i].sub[j]._id===id);
      if(site.menuItems[i].sub[j]._id.equals(id)){
        console.log('return sub',site.menuItems[i].sub[j]._id);
        site.menuItems[i].sub[j]=object;
        return site;
      }
    }
  }
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
  console.log(req.body);
  Site.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

exports.set = function(req,res){
  // Site.findByIdAsync(req.params.id)
  // .then(function(site){
  //   if(req.body.parentId){
  //     // findMenuItem(site,req.body.id,req.body);
  //   }else{
  //     console.log('noooo');
  //     // findMenuItem(site,req.body.id,req.body);
  //   }
  //   saveUpdates()(site)
  //   .then(responseWithResult(res))
  //   .catch(handleError(res));
  // });
};

// Deletes a site from the DB.
exports.destroy = function(req, res) {
  Site.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
