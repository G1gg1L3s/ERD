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
    await models.tags.bulkCreate(doc.tags, {
      fields: ['value'],
      updateOnDuplicate: ['value']
    });

    const tagValues = doc.tags.map(tag => tag.value);
    const tags = await models.tags.findAll({
      where: {
        value: { [Op.in]: tagValues }
      }
    });

    const include = [{ model: models.metadata, as: 'metadata' }];
    const document = await this.db.models.documents.create(doc, { include });
    await document.setTags(tags);
    return document;
  }

  async delete(id) {
    const doc = await this.getById(id);
    return doc.destroy();
  }
}

module.exports = Documents;
