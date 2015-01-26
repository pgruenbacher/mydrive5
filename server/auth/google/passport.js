var passport = require('passport');
var GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;
var User = require('../../sqldb').User;

exports.setup = function(User, config) {
  passport.use(new GoogleStrategy({
    clientID: config.google.clientID,
    clientSecret: config.google.clientSecret,
    callbackURL: config.google.callbackURL
  },
  function(accessToken, refreshToken, profile, done) {
    User.find({where:{'email':profile._json.email}})
      .then(function(user) {
        if (!user) {
          user = User.build({
            name: profile.displayName,
            email: profile.email,
            role: 'user',
            username: profile.username,
            googleToken:accessToken,
            googleRefreshToken:refreshToken,
            google: JSON.stringify(profile._json)
          });
          user.save()
            .then(function(user) {
              return done(null, user);
            })
            .catch(function(err) {
              return done(err);
            });
        } else {
          user.googleToken=accessToken;
          user.googleRefreshToken=refreshToken;
          user.google=JSON.stringify(profile._json);
          user.save()
          .then(function(){
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
  }));
};
