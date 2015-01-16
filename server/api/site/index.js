'use strict';

var express = require('express');
var controller = require('./site.controller');
var auth = require('../../auth/auth.service');


var router = express.Router();

router.get('/', auth.hasRole('admin'), controller.index);
router.get('/find', controller.find);
router.get('/:domainName', controller.show);
router.post('/', auth.hasRole('admin'), controller.create);
router.put('/:id', controller.update);
router.put('/:id/home',auth.hasRole('admin'),controller.setHome);
router.put('/:id/menu/:menuId/sub/:subId', auth.hasRole('admin'),controller.setSub);
router.put('/:id/menu/:menuId',auth.hasRole('admin'), controller.setMenu);
router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);

module.exports = router;
