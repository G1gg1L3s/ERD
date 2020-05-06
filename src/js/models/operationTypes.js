'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('operation_types', {
    id,
    name: { type: Sequelize.STRING(45), allowNull: false },
  });

  const associate = models => {
    model.hasMany(models.requestTypes, {
      foreignKey: 'operation_type',
      as: 'operations'
    });
  };

  return { model, associate };
};
