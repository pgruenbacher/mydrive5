'use strict';

var express = require('express');
var passport = require('passport');
var config = require('../config/environment');
var User = require('../sqldb').User;

// Passport Configuration
require('./local/passport').setup(User, config);
require('./facebook/passport').setup(User, config);
require('./google/passport').setup(User, config);
require('./twitter/passport').setup(User, config);
require('./stripe/passport').setup(User,config);

var router = express.Router();

router.use('/local', require('./local'));
router.use('/facebook', require('./facebook'));
router.use('/twitter', require('./twitter'));
router.use('/google', require('./google'));
router.use('/stripe',require('./stripe'));

module.exports = router;
