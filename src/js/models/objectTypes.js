'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('object_types', {
    id,
    name: { type: Sequelize.STRING(45), allowNull: false },
  });

  const associate = models => {
    model.hasMany(models.requestTypes, {
      foreignKey: 'object_type',
      as: 'requests'
    });
  };

  return { model, associate };
};
