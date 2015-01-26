var g=require('./index');
var google=g.google;
var auth=g.auth;
var compose = require('composable-middleware');
// var config=require('../../config/environment');

function verifyToken(){
  return compose()
    .use(function(req,res,next){
      if(typeof req.cookies.googleToken ==='undefined'){
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
      auth.setCredentials({
        access_token:req.cookies.googleToken
      });
      console.log(req.cookies.googleToken);
      var drive=google.drive('v2')
      drive.files.insert({
        resource: {
          title: 'Angular 2.0!!!',
          mimeType: 'text/plain'
        },
        media: {
          mimeType: 'text/plain',
          body: 'Hello World'
        },
        auth: auth
      }, function(err){
        console.log(typeof err);

        if(err){
          if(err.code===401){
            res.status(409).json({redirect:true}).end();
          }
        }
        else{
          next()
        }
      });
    });
}

exports.saveFiles=saveFiles;