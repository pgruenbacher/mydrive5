'use strict';

var express = require('express');
var passport = require('passport');
var auth = require('../auth.service');
var _ = require('lodash');

var User = require('../../sqldb').User;

var router = express.Router();

function initiatePassportStrategy(req,res,next,params){
  passport.authenticate('stripe', _.merge({
    failureRedirect: '/signup',
    scope:'read_write',
    session: false
  }, params))(req,res,next)
}

router
  .get('/', function(req,res,next){
    var params={};
    if(typeof req.query.email !=='undefined'){
      params={
        'stripe_user[email]':req.query.email,
        'stripe_user[first_name]':req.query.firstName,
        'stripe_user[last_name]':req.query.lastName,
        'stripe_user[phone_number]':req.query.phoneNumber,
        'stripe_user[business_name]':req.query.businessName,
        'stripe_user[business_type]':req.query.businessType,
        'stripe_user[dob_day]':req.query.day,
        'stripe_user[dob_month]':req.query.month,
        'stripe_user[dob_year]':req.query.year,
        'stripe_user[street_address]':req.query.streetAddress,
        'stripe_user[city]':req.query.city,
        'stripe_user[state]':req.query.state,
        'stripe_user[country]':'US',
        'stripe_user[zip]':req.query.zip,
        'stripe_user[product_description]':req.query.productDescription,
        'stripe_user[website]':req.query.website
      };
      console.log(req.query.email);
      User.find({where:{'email':req.query.email,active:true}}).then(function(userObject){
        console.log(userObject);
        if(userObject === null){
          var user=User.build(req.query);
          user.provider='stripe';
          user.active=false;
          user.save();
          initiatePassportStrategy(req,res,next,params);
        }else{
          console.log('email already exists');
          return res.json({message:'email already exists'});
        }
      });
    }else{
      initiatePassportStrategy(req,res,next,params);
    }
    
  })
  .get('/callback', passport.authenticate('stripe', {
    failureRedirect: '/signup',
    session: false
  }), auth.setTokenCookie);

module.exports = router;