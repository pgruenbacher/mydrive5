'use strict';

var _ = require('lodash');
var Subscriber = require('./subscriber.model');
// var csv = require('csv');
// var stringify = csv.stringify;
// var generate = csv.generate;
// var fs = require('fs');
var csvify = require('../csvify.js');
var map = require('map-stream');
var google = require('../../../components/google/drive');

var Common = require('../../api.service');
var handleError=Common.handleError;
var responseWithResult=Common.responseWithResult;
var handleEntityNotFound=Common.handleEntityNotFound;
var saveUpdates=Common.saveUpdates;
var removeEntity=Common.removeEntity;
var verifySiteOwnership=Common.verifySiteOwnership;
var extendAndSave=Common.extendAndSave;


// Gets list of subscribers from the DB.
exports.index = function(req, res) {
  Subscriber.findAsync()
    .then(responseWithResult(res))
    .catch(handleError(res));
};

exports.googleSave = function(req,res){
  res.status(200).json({a:'asdf'}).end()
};

exports.download = function(req,res){
  // var generator = generate({seed:1,columns: 20, length: 100});
  // var stringifier = stringify({delimiter:','});
  // var writeStream = fs.createWriteStream('subscribers.csv');

  res.writeHead(200, {
    'Content-Type': 'text/csv',
    'Content-Disposition': 'attachment; filename=subscribers.csv'
  });
  res.write(csvify.rowFromArray(Subscriber.csvHeader()));

  Subscriber.find()
  // csv.generate({seed: 1, columns: 2, length: 20})
  .stream()
  .pipe(map(function teamToArray (team, callback) {
    callback(null, team.mapToCSV());
  }))
  .pipe(map(function myCSVify (data, callback) {
    callback(null, csvify.rowFromArray(data));
  }))
  .on('error', function csvError (err) {
    console.log("oh noes, csv error!", err.stack);
  })
  .pipe(res);


  // .pipe(through(function write(doc){
  //   this.queue(_.values(doc.toObject({getters:true, virtuals:false})));
  // }, function end(){
  //   console.log('done');    
  // }))
};

// Gets a single subscriber from the DB.
exports.show = function(req, res) {
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Creates a new subscriber in the DB.
exports.create = function(req, res) {
  Subscriber.createAsync(req.body)
    .then(responseWithResult(res, 201))
    .catch(handleError(res));
};

// Updates an existing subscriber in the DB.
exports.update = function(req, res) {
  if (req.body._id) {
    delete req.body._id;
  }
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(saveUpdates(req.body))
    .then(responseWithResult(res))
    .catch(handleError(res));
};

// Deletes a subscriber from the DB.
exports.destroy = function(req, res) {
  Subscriber.findByIdAsync(req.params.id)
    .then(handleEntityNotFound(res))
    .then(removeEntity(res))
    .catch(handleError(res));
};
