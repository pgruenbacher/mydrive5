'use strict';

var express = require('express');
var controller = require('./site.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/find',controller.find);
router.get('/:domainName', controller.show);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);

module.exports = router;
