/**
 * Main application file
 */

'use strict';

// Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

var express = require('express');
var mongoose = require('mongoose-bird')();
var sqldb = require('./sqldb');
var config = require('./config/environment');
var multer = require('multer');

// var subdomain = require('subdomain');
var vhost=require('vhost');

// Connect to MongoDB
mongoose.connect(config.mongo.uri, config.mongo.options);

// Populate databases with sample data
if (config.seedDB) { require('./config/seed'); }

// Setup server
var app = express();
var server = require('http').createServer(app);
var socketio = require('socket.io')(server, {
  serveClient: (config.env === 'production') ? false : true,
  path: '/socket.io-client'
});

// app.use(subdomain({ base : 'mydrive5', removeWWW : true }));



app.use(require('prerender-node').set('prerenderToken', config.prerender.token));
//Muler Upload Settings
app.use(multer({ 
  dest: './tmp',
  rename: function (fieldname, filename) {
    return filename+Date.now();
  },
  onFileUploadStart: function (file) {
    console.log(file.originalname + ' is starting ...')
  },
  onFileUploadData: function (file, data) {
    //console.log(data.length + ' of ' + file.fieldname + ' arrived')
  },
  onFilesLimit: function () {
    console.log('Crossed file limit!')
  },
  onFieldsLimit: function () {
    console.log('Crossed fields limit!')
  },
  limits: {
    fieldNameSize: 100,
    files: 5,
    fields: 12
  },
  onFileUploadComplete: function (file) {
    console.log(file.fieldname + ' uploaded to  ' + file.path)
  }
}));




var redirect = express();
var main=express();

require('./config/socketio')(socketio);

require('./config/express')(main);
require('./config/express')(redirect);

require('./routes')(main,'index.html');
require('./routes')(redirect,'public.index.html');


app.use(vhost('*.mydrive5.com', redirect));
app.use(vhost('localhost',main));


// Start server
function startServer() {
  server.listen(config.port, config.ip, function() {
    console.log('Express server listening on %d, in %s mode', config.port, app.get('env'));
  });
}

sqldb.sequelize.sync()
  .then(startServer)
  .catch(function(err) {
    console.log('Server failed to start due to error: %s', err);
  });


// Expose app
exports = module.exports = app;
