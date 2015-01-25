'use strict';

var express = require('express');
var passport = require('passport');
var auth = require('../auth.service');
var User = require('../../sqldb').User;

var router = express.Router();

router
  .get('/', passport.authenticate('google', {
    failureRedirect: '/signup',
    scope: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ],
    session: false
  }))

  .get('/drive', passport.authenticate('google', {
    failureRedirect: '/signup',
    callbackURL:'http://localhost:9000/auth/google/callback/drive',
    scope: [
      'https://www.googleapis.com/auth/drive.file',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ],
    session: false
  }))

  .get('/callback', passport.authenticate('google', {
    failureRedirect: '/signup',
    session: false
  }), auth.setTokenCookie)


  .get('/callback/drive', passport.authenticate('google', {
    callbackURL:'http://localhost:9000/auth/google/callback/drive',
    failureRedirect: '/signup',
    session: false
  }), function(req,res){
    res.cookie('googleToken', req.user.googleToken);
    res.redirect('/admin/data');
  });

module.exports = router;
