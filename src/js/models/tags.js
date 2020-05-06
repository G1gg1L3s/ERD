'use strict';

const id = require('./id');
const Sequelize = require('sequelize');

module.exports = sequelize => {
  const model = sequelize.define('tags', {
    id,
    value: { type: Sequelize.STRING(45), allowNull: false },
  });

  const associate = models => {
    model.belongsToMany(models.documents, {
      foreignKey: 'tag_id',
      through: 'links'
    });
  };

  return { model, associate };
};
