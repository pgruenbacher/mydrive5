'use strict';

var express = require('express');
var controller = require('./subscriber.controller');
var auth = require('../../../auth/auth.service');
var passport = require('passport');

var router = express.Router();

router.get('/', controller.index);

var google=require('../../../components/google/drive');

// router.get('/google',
//   passport.authenticate('google', {
//     failureRedirect: '/login',
//     scope: [
//       'https://www.googleapis.com/auth/drive.file'
//     ],
//     session: false
//   })
// );
// router.get('/google/callback',
//   passport.authenticate('google', {
//     failureRedirect: '/signup',
//     session: false
//   }),
//   controller.googleSave
// );
router.get('/google',auth.hasRole('admin'),google.saveFiles(),controller.googleSave);


router.get('/download',controller.download);
router.get('/:id', controller.show);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);

module.exports = router;
