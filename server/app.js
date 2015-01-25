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

var google = require('googleapis');
var OAuth2 = google.auth.OAuth2;
var oauth2Client = new OAuth2(config.google.clientId, config.google.clientSecret, config.google.callbackURL);
google.options({ auth: oauth2Client }); // set auth as a global default


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

require('./config/express')(main,'client');
require('./config/express')(redirect,'public');

require('./routes')(main);
require('./public')(redirect);

// production domains
// Using goDaddy.com CNAME
app.use(vhost('www.mydrive5.com', main));
app.use(vhost('*.mydrive5.com', redirect));
app.use(vhost('mydrive5.herokuapp.com',main));

// testing domains
if(process.env.NODE_ENV==='development'){
  app.use(vhost('www.mydrive5test.com', main));
  app.use(vhost('*.mydrive5test.com', redirect));
  app.use(vhost('localhost',main));
  app.use(vhost('mydrive5test.testapp.com',main));
  app.use(vhost('*.mydrive5test.testapp.com', redirect));
}


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
