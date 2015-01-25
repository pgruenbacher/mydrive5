var passport = require('passport');
var StripeStrategy = require('passport-stripe').Strategy;
var User=require('../../sqldb').User

exports.setup = function (User, config) {
  passport.use(new StripeStrategy({
      clientID: config.stripe.clientID,
      clientSecret: config.stripe.clientSecret,
      callbackURL: config.stripe.callbackURL
    },
    function(accessToken, refreshToken, profile, done) {
      
      var Stripe=require('stripe')(accessToken);      
      Stripe.account.retrieve(function(err, account) {
        User.find({where:{'email': account.email}}).then(function(user) {
          if (user===null) {
            user = User.build({
              name: 'administrator',
              email: account.email,
              role: 'admin',
              username: 'account.email',
              provider: 'stripe',
              active: true,
              stripe:JSON.stringify(account),
              stripeToken: accessToken,
              stripeRefreshToken: refreshToken
            });
            user.save().then(function(user) {
              return done(null, user);
            })
            .catch(function(err) {
              return done(err);
            });
          } else {
            // var something=user.updateAttributes({
            //    role: 'admin',
            //   provider: 'stripe',
            //   active:true
            // });
            user.role='admin';
            user.provider='stripe';
            user.active=true;
            user.stripe=JSON.stringify(account);
            user.stripeToken=accessToken;
            user.stripeRefreshToken=refreshToken;

            user.save().then(function(user){
              return done(null, user);
            })
            .catch(function(err) {
              return done(err);
            });
          }
        })
        .catch(function(err) {
          return done(err);
        });
      });
    }
  ));
};
