'use strict';
var _ = require('lodash');

module.exports={
  handleError:function(res, statusCode) {
    statusCode = statusCode || 500;
    return function(err) {
      console.log(err);
      res.status(statusCode).send(err);
    };
  },

  responseWithResult:function(res, statusCode) {
    statusCode = statusCode || 200;
    return function(entity) {
      if (entity) {
        return res.status(statusCode).json(entity);
      }
    };
  },
  verifySiteOwnership:function(res,userId){
    return function(entity){
      if(userId !== entity.user._id){
        res.send(401).end();
        return entity;
      }else{
        return entity;
      }
    }
  },
  handleEntityNotFound:function(res) {
    return function(entity) {
      if (!entity) {
        res.send(404);
        return null;
      }
      return entity;
    };
  },
  extendAndSave:function(updates){
    return function(entity){
      _.extend(entity,updates);
      return entity.saveAsync();
    };
  },
  saveUpdates:function(updates) {
    return function(entity) {
      return entity.updateAttributes(updates)
        .then(function(updated) {
          return updated;
        });
    };
  },

  removeEntity:function(res) {
    return function(entity) {
      if (entity) {
        return entity.destroy()
          .then(function() {
            return res.send(204);
          });
      }
    };
  },
  validationError : function(res, statusCode) {
    statusCode = statusCode || 422;
    return function(err) {
      res.status(statusCode).json(err);
    };
  }
}

