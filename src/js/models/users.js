'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('users', {
    id,
    name: { type: Sequelize.STRING(45), allowNull: false },
    password: { type: Sequelize.STRING(255), allowNull: false },
    email: { type: Sequelize.STRING(255), allowNull: false },
  });

  const associate = models => {
    model.belongsToMany(models.roles, {
      through: 'assignments',
      foreignKey: 'user_id',
    });

    model.hasMany(models.events, {
      foreignKey: 'user_id',
      as: 'events',
    });

    model.belongsToMany(models.roles, {
      through: 'assignments',
      foreignKey: 'user_id',
    });

    model.belongsToMany(models.requestTypes, {
      through: 'grants',
      foreignKey: 'user_id',
    });

  };

  return { model, associate };
};
