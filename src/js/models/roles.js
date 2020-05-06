'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('roles', {
    id,
    name: { type: Sequelize.STRING(45), allowNull: false },
    description: { type: Sequelize.STRING(255), allowNull: true },
  });

  const associate = models => {
    model.belongsToMany(models.users, {
      through: 'assignments',
      foreignKey: 'role_id',
    });

    model.belongsToMany(models.requestTypes, {
      through: 'grants',
      foreignKey: 'role_id',
    });
  };

  return { model, associate };
};
