'use strict';

const Sequelize = require('sequelize');

const MODEL_NAMES = [
  'assignments',
  'documents',
  'events',
  'extras',
  'grants',
  'links',
  'metadata',
  'objectTypes',
  'operationTypes',
  'requestTypes',
  'roles',
  'tags',
  'users',
];

class DB {
  constructor(options) {
    this.sequelize = new Sequelize(options);
    this.models = {};
  }

  static async create(options) {
    const db = new DB(options);
    await db.sequelize.authenticate();
    await db.loadModels(MODEL_NAMES);
    return db;
  }

  async loadModels(list) {
    const assocations = [];
    list.forEach(name => {
      const { model, associate } = require(`./${name}.js`)(this.sequelize);
      this.models[name] = model;
      assocations.push(associate);
    });
    assocations.forEach(associate => associate(this.models));
  }

  async close() {
    return this.sequelize.close();
  }
}

module.exports = DB;
