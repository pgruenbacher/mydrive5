'use strict';
var match;
if (process.env.HEROKU_POSTGRESQL_ORANGE_URL) {
  // the application is executed on Heroku ... use the postgres database
  match = process.env.HEROKU_POSTGRESQL_ORANGE_URL.match(/postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);
}else{
  match=['','','','','',''];
}
// Production specific configuration
// =================================
module.exports = {
  // Server IP
  ip:       process.env.OPENSHIFT_NODEJS_IP ||
            process.env.IP ||
            undefined,

  // Server port
  port:     process.env.OPENSHIFT_NODEJS_PORT ||
            process.env.PORT ||
            8080,

  // MongoDB connection options
  mongo: {
    uri:    process.env.MONGOLAB_URI ||
            process.env.MONGOHQ_URL ||
            process.env.OPENSHIFT_MONGODB_DB_URL +
            process.env.OPENSHIFT_APP_NAME ||
            'mongodb://localhost/mydrive5'
  },
  sequelize: {
    database:match[5],
    username:match[1],
    password:match[2],
    options: {
      dialect:'postgres',
      protocol:'postgres',
      port:match[4],
      host:match[3],
      logging: false
    }
  }
};
