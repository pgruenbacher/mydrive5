'use strict';

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
      console.log('entity verify',userId,entity.user._id);
      if(userId !== entity.user._id){
        console.log('not owned');
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

