/**
 * Main application routes
 */

'use strict';

var errors = require('./components/errors');
var path = require('path');



module.exports = function(app) {

  // Insert routes below
  app.use('/api/data/customs', require('./api/data/custom'));
  app.use('/api/data/participants', require('./api/data/participant'));
  app.use('/api/data/subscribers', require('./api/data/subscriber'));
  app.use('/api/forms', require('./api/form'));
  app.use('/api/posts', require('./api/post'));
  app.use('/api/sites', require('./api/site'));
  app.use('/api/images', require('./api/image'));
  app.use('/api/things', require('./api/thing'));
  app.use('/api/users', require('./api/user'));

  app.use('/auth', require('./auth'));

  // All undefined asset or api routes should return a 404
  app.route('/:url(api|auth|subdomain|components|app|bower_components|assets)/*')
   .get(errors[404]);

  // All other routes should redirect to the index.html
  app.route('/*')
  .get(function(req, res) {
    console.log('get inde');
    res.sendFile(path.resolve(app.get('appPath') + '/index.html'));
  });
};
