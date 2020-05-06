'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('events', {
    id,
    'user_id': { type: Sequelize.INTEGER, allowNull: false },
    date: { type: Sequelize.DATE, allowNull: false },
  });

  const associate = models => {
    model.hasMany(models.extras, {
      foreignKey: 'event_id',
      as: 'extras',
    });

    model.belongsTo(models.users, {
      foreignKey: 'user_id',
      as: 'user',
    });
  };

  return { model, associate };
};
