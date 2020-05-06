'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('request_types', {
    id,
    name: { type: Sequelize.STRING(45), allowNull: false },
    'object_type': { type: Sequelize.INTEGER, allowNull: false },
    'operation_type': { type: Sequelize.INTEGER, allowNull: false },
  });

  const associate = models => {
    model.belongsTo(models.operationTypes, {
      foreignKey: 'operation_type',
      as: 'operation'
    });

    model.belongsTo(models.objectTypes, {
      foreignKey: 'object_type',
      as: 'object'
    });

    model.belongsToMany(models.users, {
      through: 'grants',
      foreignKey: 'request_type_id',
    });

    model.belongsToMany(models.roles, {
      through: 'grants',
      foreignKey: 'request_type_id',
    });
  };

  return { model, associate };
};
