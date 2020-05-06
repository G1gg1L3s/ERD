'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('metadata', {
    id,
    'document_id': { type: Sequelize.INTEGER, allowNull: false },
    keyy: { type: Sequelize.STRING(45), allowNull: false },
    value: { type: Sequelize.STRING(255), allowNull: true }
  });

  const associate = models => {
    model.belongsTo(models.documents, {
      foreignKey: 'document_id',
      as: 'document',
    });
  };

  return { model, associate };
};

