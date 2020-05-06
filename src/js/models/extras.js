'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('extras', {
    id,
    'event_id': { type: Sequelize.INTEGER, allowNull: false },
    keyy: { type: Sequelize.STRING(45), allowNull: false },
    value: { type: Sequelize.STRING(255), allowNull: true }
  });

  const associate = models => {
    model.belongsTo(models.events, {
      foreignKey: 'event_id',
      as: 'event',
    });
  };

  return { model, associate };
};

