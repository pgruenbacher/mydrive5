var config = require('../../config/environment')
var googleapis=require('googleapis');
var OAuth2 = googleapis.auth.OAuth2;
var oauth2Client = new OAuth2(config.google.clientId, config.google.clientSecret, config.google.callbackURL);

exports.auth=oauth2Client;
exports.google=googleapis;