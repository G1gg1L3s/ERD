'use strict';

module.exports = {
  db: {
    database: 'erd',
    username: 'erd_test',
    password: 'test',
    dialect: 'mysql',
    define: {
      timestamps: false
    },

    pool: {
      max: 5,
      idle: 30000,
      acquire: 60000,
    },
  }
};
