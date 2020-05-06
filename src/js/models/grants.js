'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('grants', {
    id,
    'user_id': { type: Sequelize.INTEGER, allowNull: true },
    'role_id': { type: Sequelize.INTEGER, allowNull: true },
    'request_type_id': { type: Sequelize.INTEGER, allowNull: false },
  });

  const associate = models => {
    model.belongsToMany(models.users, {
      through: 'grants',
      foreignKey: 'request_type_id',
    });

    model.belongsToMany(models.roles, {
      through: 'grants',
      foreignKey: 'request_type_id',
    });

    model.belongsTo(models.requestTypes, {
      foreignKey: 'request_type_id',
      as: 'request',
    });
  };

  return { model, associate };
};
