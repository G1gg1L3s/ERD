'use strict';

const { Op } = require('sequelize');

const makeInclude = documents => {
  const { metadata, tags } = documents.db.models;
  return [
    { model: metadata, as: 'metadata' },
    { model: tags, as: 'tags' },
  ];
};

class Documents {
  constructor(db) {
    this.db = db;
  }

  async getAll() {
    const include = makeInclude(this);
    return this.db.models.documents.findAll({ include });
  }

  async getById(id) {
    const include = makeInclude(this);
    return this.db.models.documents.findByPk(id, { include });
  }

  async add(doc) {
    const models = this.db.models;

    const tags = await this.getOrCreate(doc.tags);

    const include = [{ model: models.metadata, as: 'metadata' }];
    const document = await this.db.models.documents.create(doc, { include });
    await document.setTags(tags);
    return document;
  }

  async delete(id) {
    const doc = await this.getById(id);
    return doc.destroy();
  }

  async getTags(values) {
    const models = this.db.models;
    return models.tags.findAll({
      where: { value: { [Op.in]: values } }
    });
  }

  async getOrCreate(tags) {
    const models = this.db.models;
    await models.tags.bulkCreate(tags, {
      fields: ['value'],
      updateOnDuplicate: ['value']
    });

    const tagValues = tags.map(tag => tag.value);
    return this.getTags(tagValues);
  }
}

module.exports = Documents;
