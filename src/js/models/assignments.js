'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('assignments', {
    id,
    'user_id': { type: Sequelize.INTEGER, allowNull: false },
    'role_id': { type: Sequelize.INTEGER, allowNull: false },
  });

  const associate = () => {};

  return { model, associate };
};
