'use strict';

var express = require('express');
var controller = require('./image.controller');

var s3 = require('../../components/aws/s3');

var router = express.Router();

router.get('/', controller.index);
router.post('/',controller.create);
router.post('/upload',controller.upload);
router.get('/s3-sign',s3.getS3Policy);

module.exports = router;
