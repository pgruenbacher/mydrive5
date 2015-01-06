'use strict';

var _ = require('lodash');
var sqldb = require('../../sqldb')
var Post = sqldb.Post;
var User = sqldb.User;

var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;


// Get list of Posts
exports.index = function(req, res) {
  Post.findAll({
    attributes:['title','subTitle','_id','createdAt'],
    include:[{
      model:User,attributes:['firstName','lastName']
    }]
  })
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Get a single thing
exports.show = function(req, res) {
  Post.find({
    where: {
      _id: req.params.id
    }
  })
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};