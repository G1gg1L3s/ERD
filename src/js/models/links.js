'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('links', {
    id,
    'document_id': { type: Sequelize.INTEGER, allowNull: false },
    'tag_id': { type: Sequelize.INTEGER, allowNull: false },
  });

  const associate = () => {};

  return { model, associate };
};
