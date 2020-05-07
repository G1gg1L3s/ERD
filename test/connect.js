'use strict';

const Sequelize = require('sequelize');
const options = require('../src/config');
const assert = require('assert');

(async () => {
  let error = null;
  const sequelize = new Sequelize(options.db);
  try {
    await sequelize.authenticate();
    console.log('Success!');
  } catch (err) {
    error = err;
  }
  assert.equal(error, null);
  sequelize.close();
})();
