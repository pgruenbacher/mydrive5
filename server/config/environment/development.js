'use strict';

// Development specific configuration
// ==================================
module.exports = {
  // MongoDB connection options
  mongo: {
    uri: 'mongodb://localhost/mydrive5-dev'
  },
  sequelize: {
    database:'mydrive5',
    username:'postgres',
    password:'stxavier1',
    options: {
      dialect:'postgres',
      port:5432,
      logging: false,
    }
  },

  seedDB: true
};
