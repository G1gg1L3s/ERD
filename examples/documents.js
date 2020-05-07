'use strict';

const options = require('../src/config');
const DB = require('../src/js/models/index');
const Documents = require('../src/js/controllers/documents');

const sieve = obj => (obj instanceof Array ?
  obj.map(a => a.get({ plain: true })) :
  obj.get({ plain: true }));

const padd = '='.repeat(process.stdout.columns * 0.3);
const log = msg => console.log('\n', padd, msg, padd);

(async () => {
  let db = null;
  try {
    db = await DB.create(options.db);
    const docs = new Documents(db);

    log('All documents');
    const allDocs = sieve(await docs.getAll());
    console.dir(allDocs, { depth: 3 });

    log('Adding new document');
    const doc = await docs.add({
      metadata: [{ keyy: 'keyyyy', value: 'valueee' }],
      tags: [{ value: 'Database' }],
    });
    console.dir(sieve(doc), { depth: 3 });

    log('Getting document with id 2');
    const id2 = sieve(await docs.getById(2));
    console.dir(id2, { depth: 3 });

    log(`Deleting document with id ${doc.id}`);
    const del = sieve(await docs.delete(doc.id));
    console.dir(del, { depth: 3 });

    log('Creating tags, if not exist');
    const tags = sieve(await docs.getOrCreate([
      { value: 'Database' },
      { value: 'One' },
    ]));
    console.dir(tags, { depth: 3 });

    log('Get documents by tags');
    const docByTags = sieve(await docs.getByTags([
      'Database',
      'Relational',
      'algebra query language',
    ]));
    console.dir(docByTags, { depth: 4 });
  } catch (err) {
    console.error(err);
  }
  if (db) db.close();
})();
