var g=require('./index');
var google=g.google;
var auth=g.auth;
var compose = require('composable-middleware');
// var config=require('../../config/environment');

function verifyToken(){
  return compose()
    .use(function(req,res,next){
      if(!req.cookies.googleToken){
        /*409 conflict, resubmit with auth*/
        res.status(409).json({redirect:true}).end();
      }else{
        next();
      }
    });
}

function saveFiles(){
  return compose()
    .use(verifyToken())
    .use(function(req,res,next){
      next()
    });
}

exports.saveFiles=saveFiles;