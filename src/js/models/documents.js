'use strict';

const id = require('./id');

module.exports = sequelize => {
  const model = sequelize.define('documents', { id });

  const associate = models => {
    model.hasMany(models.metadata, {
      foreignKey: 'document_id',
      as: 'metadata',
    });

    model.belongsToMany(models.tags, {
      foreignKey: 'document_id',
      through: 'links'
    });
  };

  return { model, associate };
};

