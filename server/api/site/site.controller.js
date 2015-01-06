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
    console.log(updates.menuItems[0].sub[0]);
    _.extend(entity, updates);
    console.log(entity.menuItems[0].sub[0]);
    return entity.saveAsync()
      .spread(function(entity) {
        return entity;
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
