var passport = require('passport');
var StripeStrategy = require('../../components/stripe-passport').Strategy;
var Thing=require('../../sqldb').Thing

exports.setup = function (User, config) {
  passport.use(new StripeStrategy({
      clientID: config.stripe.clientID,
      clientSecret: config.stripe.clientSecret,
      callbackURL: config.stripe.callbackURL
    },
    function(accessToken, refreshToken, profile, done) {
      
      var Stripe=require('stripe')(accessToken);      
      Stripe.account.retrieve(function(err, account) {
        console.log('account',account.email);        
        User.find({where:{'email': account.email}}).then(function(user) {
          if (user===null) {
            console.log('user not found');
            user = User.build({
              name: 'administrator',
              email: account.email,
              role: 'admin',
              username: 'account.email',
              provider: 'stripe',
              active: true,
              stripeToken: accessToken,
              stripeRefreshToken: refreshToken
            });
            user.save().then(function(user) {
              console.log('new user saved',accessToken);
              return done(null, user);
            })
            .catch(function(err) {
              return done(err);
            });
          } else {
            console.log('update attributes',user._id,user.email,user.role);
            // var something=user.updateAttributes({
            //    role: 'admin',
            //   provider: 'stripe',
            //   active:true
            // });
            user.role='admin';
            user.provider='stripe';
            user.active=true;
            user.stripeToken=accessToken;
            user.stripeRefreshToken=refreshToken;

            user.save().then(function(user){
              return done(null, user);
            })
            .catch(function(err) {
              console.log('err');
              return done(err);
            });
          }
        })
        .catch(function(err) {
          console.log('error',err);
          return done(err);
        });
      });
    }
  ));
};
