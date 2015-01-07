'use strict';

var config=require('../../config/environment');
var aws=require('aws-sdk');
aws.config.update({accessKeyId: config.aws.key, secretAccessKey: config.aws.secret});
var Blitline=require('simple_blitline_node');
var blitline=new Blitline();
var nodeutil=require('util');
var fs=require('fs');

var _ = require('lodash');
var sqldb = require('../../sqldb')
var Image = sqldb.Image;


var Common = require('../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;

// Gets list of images from the DB.
function createThumbnail(location,callback){
  blitline.addJob({
    'application_id':config.blitline.id,
    'src':location,
    'functions':[
      {
        'name':'resize_to_fit',
        'params':{
          'height':150,
          'gravity':'CenterGravity'
        },
        'save':{
          'image_identifier':config.aws.key
        }
      }
    ]
  });
  blitline.postJobs(function(response){
    console.log('thumbnail created',nodeutil.inspect(response,{color:true,depth:10}));
    callback(response);
  });
}

function formatMediaEmbed(images){
  var array=[];
  var j=0;
  console.log('populating for editor browser');
  for(var i=0; i<images.length; i++){
    if(typeof images[i].urlPath!=='undefined'){
      array.push({
        image:images[i].urlPath,
        folder:'my images'
      });
    }
    console.log(images[i].Thumbnail);
    if(typeof images[i].Thumbnail.urlPath !== 'undefined'){
      console.log('setting thumb');
      array[j].thumb=images[i].Thumbnail.urlPath;
    }
    j++;
  }
  return array;
}


exports.index = function(req, res) {
  Image.findAll({
    where:{OriginalId:{not:0}},
    include:[{model:Image,as:'Thumbnail'}]
  })
    .then(function(images){
      var library;
      if(req.query.type==='editorBrowser'){
        library=formatMediaEmbed(images);
      }else{
        library=images;
      }
      responseWithResult(res)(library)
    })
    .catch(handleError(res));
};

exports.create = function(req, res){
  var originalImage,thumbnailImage;
  createThumbnail(req.body.location,function(response){
    originalImage=Image.build(req.body.image);
    thumbnailImage=Image.build({
      urlPath:response.results[0].images[0].s3_url,
      imageIdentifier:response.results[0].images[0].image_identifier
    });
    originalImage.save().then(function(){
      originalImage.setThumbnail(thumbnailImage).then(function(){
          originalImage.setOriginal(thumbnailImage).then(responseWithResult(res, 201))
        })
        .catch(handleError(res));
      })
      .catch(handleError(res));
  });
};

exports.upload=function(req,res){
  console.log(req.file,req.files);
  var uploadBucket=new aws.S3({
    params:{
      Bucket:'mydrive5'
    }
  });
  fs.readFile(req.files.upload.path,function(err,data){
    if(err){throw err;}
    var params={
      Key:'s3UploadExample/'+req.files.upload.name,
      Body:data,
      ACL:'public-read'
    };
    uploadBucket.upload(params)
      .on('httpUploadProgress', function(evt) { console.log('aws progress'); })
      .send(function(err, awsResponse) {
        createThumbnail(awsResponse.Location,function(response){
          var originalImage=Image.build({
            urlPath: awsResponse.Location,
            size: req.files.upload.size,
            mimetype: req.files.upload.mimetype,
            name: req.files.upload.name,
            extension:req.files.upload.extension,
            originalName:req.files.upload.originalName
          });
          var thumbnailImage=Image.build({
            urlPath:response.results[0].images[0].s3_url,
            imageIdentifier:response.results[0].images[0].image_identifier,
            mimetype: req.files.upload.mimetype,
            name: req.files.upload.name,
            extension:req.files.upload.extension,
            originalName:req.files.upload.originalName
          });
          originalImage.save().then(function(){
            originalImage.setThumbnail(thumbnailImage).then(function(){
              originalImage.setOriginal(thumbnailImage)
                .then(function(){res.send('finished uploading')})
                .catch(handleError(res));
            })
            .catch(handleError(res));
          })
          .catch(handleError(res));
        });
      });
  });
};

exports.signS3 = function (req,res){
  var s3 = new aws.S3();
  var s3_params = {
    Bucket: config.aws.bucket,
    Key: req.query.s3ObjectName,
    Expires: 60,
    ContentType: req.query.s3_object_type,
    ACL: 'public-read'
  };
  s3.getSignedUrl('putObject', s3_params, function(err, data){
    if(err){
      console.log(err);
    }
    else{
      var return_data = {
        signed_request: data,
        url: 'https://'+config.aws.bucket+'.s3.amazonaws.com/'+req.query.s3ObjectName,
        policy: s3.getS3Policy()
      };
      res.write(JSON.stringify(return_data));
      res.end();
    }
  });
};