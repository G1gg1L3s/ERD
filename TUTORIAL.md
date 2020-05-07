1. Що таке орм
2. Наша ерм і проблема яка стоїть за нею

# 3. Реляційна схема
Реляційна схема описаного вище Електронного реєстру документів має такий вигляд:
![ERM](docs/RM.png)

# 4. Представлення моделей в ноді за допомогою Sequelize
Sequelize - це заснована на промісах ORM Node.js для Postgres, MySQL, MariaDB, SQLite та Microsoft SQL Server.

## 4.1 Встановлення
Sequelize доступний через npm (або yarn).
```bash
$ npm install sequelize
```

Також для роботи доведеться вручну встановити драйвер для обраної бази данних:
```bash
# Один з цих:
$ npm install pg pg-hstore # Postgres
$ npm install mysql2
$ npm install mariadb
$ npm install sqlite3
$ npm install tedious # Microsoft SQL Server
```

## 4.2 Налаштування з'єднання
Для підключення до бази даних необхідно створити екземпляр Sequelize. Це можна зробити, передавши параметри з'єднання або URI конструктору Sequelize:
```js
const Sequelize = require('sequelize');

// Варіант 1: Передача параметрів окрмео
const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: /* один з 'mysql' | 'mariadb' | 'postgres' | 'mssql' */
});

// Ваіант 2: Передача URI
const sequelize = new Sequelize('postgres://user:pass@example.com:5432/dbname');


// Варіант 3: передача параметрів
const options = {
  database: 'database',
  username: 'username',
  password: 'password',
  dialect: 'mysql',
  define: { timestamps: false }, // Це для того, щоб sequelize не додавав свої поля до таблиць, як createdAt або updatedAt.

  // Налаштування пулу з'єднань
  pool: {
    max: 5,
    idle: 30000,
    acquire: 60000,
  },
};

const sequelize = new Sequelize(options);
```

Для перевірки з'єднання з бд:

```js
const sequelize = new Sequelize(options);

sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });
```

Sequelize буде тримати процес відкритим. Для закриття з'єднання:
```js
sequelize.close()
  .then(/*success*/)
  .catch(/*error*/)
```
## 4.3 Моделювання
Модель це класс який розширює Sequelize.Model. Вона може бути задана двома шляхами:
Перший, використовуючи Sequelize.Model.init(attributes, options):

```js
const Model = Sequelize.Model;
class User extends Model {}
User.init({
  // attributes
  firstName: {
    type: Sequelize.STRING,
    allowNull: false
  },
  lastName: {
    type: Sequelize.STRING
    // allowNull defaults to true
  }
}, {
  sequelize,
  modelName: 'user'
  // options
});
```

Альтернатива sequelize.define:

```js
const User = sequelize.define('user', {
  // attributes
  firstName: {
    type: Sequelize.STRING,
    allowNull: false
  },
  lastName: {
    type: Sequelize.STRING
    // allowNull defaults to true
  }
}, {
  // options
});
```

Код зверху говорить Sequelize про існування таблиці `users` в базі данних з полями `firstName` and `lastName`.

Ім'я таблиці автоматично отримується з імені моделі, шляхом перетворення його на множину, бібліотекою inflection під капотом. 
Це можна зупинити за допомогою `freezeTableName: true` властивістю в налаштуваннях або використовуючи `define` конструктор.

Більше про типи данних у [документації sequelize](https://sequelize.org/v5/manual/data-types.html).

# 4.4 Синхронізація з базою данних
Для створення або редагування таблиці після створення моделі використовується метод `sync`:

```js
(async () => {

  // УВАГА: `force: true` спочатку дропне таблицю, а потім створить її знову.
  await User.sync({ force: true });
  // Тепер таблиця `users` у бд відповідає моделі User

  await User.create({
      firstName: 'John',
      lastName: 'Hancock'
    });

})();
```

Замість того, щоб синхронізувати кожну модель окремо, для синхронізації всієї бази данних:
```js
await sequelize.sync();
```

# 4.5 Прості запити
Sequelize має багато налаштувань для запитів. Найпростіші з них:
```js
(async () => {

  // Отримати всіх користувачів
  const users = await User.findAll();
  console.log("All users:", JSON.stringify(users, null, 4));
  
  // Створення нового.
  const jane = User.create({ firstName: "Jane", lastName: "Doe" });
  console.log("Jane's auto-generated ID:", jane.id);
  
  // Видалити всіх "Jane"
  await User.destroy({
    where: {
      firstName: "Jane"
    }
  })
  console.log("Done");
  
  // Змінити всіх з прізвищем "Doe"
  await User.update({ lastName: "Doe" }, {
    where: {
      lastName: null
    }
  });
  console.log("Done");

})();
```

Всі види запитів повертають або об'єкти класу того ж що і модель, або масив таких об'єктів. Разом з данними повертається багато метаданних. Для очищення цих об'єктів від метаданних використовується метод `get`:

```js
// Знайти користувача з id = 1
const user = await User.findByPk(1);

console.dir(user); // Багато метаданних

console.dir(user.get({ plain: true })); // Тепер без
// або
console.dir(JSON.stringify(user)); // Тепер без у форматі json
```

# 5. Використання sequelize у ЕРД.
Все, про що йтиме мова нижче, можна побачити у [нашому репозиторії](https://github.com/G1gg1L3s/ERD).

## 5.1 Моделювання
На початку роботи з sequelize потрібно створити всі потрбіні моделі та зв'язки між ними.
Для прикладу візьмемо такі сутності:
- Документи:

| Field | Type    | Null | Key | Default | Extra          |
|-------|---------|------|-----|---------|----------------|
| id    | int(11) | NO   | PRI | NULL    | auto_increment |


- Метаданні документів:

| Field       | Type         | Null | Key | Default | Extra          |
|-------------|--------------|------|-----|---------|----------------|
| id          | int(11)      | NO   | PRI | NULL    | auto_increment |
| document_id | int(11)      | NO   | MUL | NULL    |                |
| keyy        | varchar(45)  | NO   | MUL | NULL    |                |
| value       | varchar(255) | YES  |     | NULL    |                |

- Теги:

| Field | Type        | Null | Key | Default | Extra          |
|-------|-------------|------|-----|---------|----------------|
| id    | int(11)     | NO   | PRI | NULL    | auto_increment |
| value | varchar(45) | NO   | UNI | NULL    |                |

- Зв'язок тег-документ:

| Field       | Type    | Null | Key | Default | Extra          |
|-------------|---------|------|-----|---------|----------------|
| id          | int(11) | NO   | PRI | NULL    | auto_increment |
| document_id | int(11) | NO   | MUL | NULL    |                |
| tag_id      | int(11) | NO   | MUL | NULL    |                |

Моделі цих сутностей у javascript виглядатимуть так:
```js
// Це поле однакове для всіх сутностей, тому є сенс винести його окремо
const id = {
  type: Sequelize.INTEGER,
  primaryKey: true,
  autoIncrement: true,
  allowNull: false,
};

const Document = sequelize.define('documents', { id });

const Metadata = sequelize.define('metadata', {
  id,
  'document_id': { type: Sequelize.INTEGER,     allowNull: false },
  keyy:          { type: Sequelize.STRING(45),  allowNull: false },
  value:         { type: Sequelize.STRING(255), allowNull: true  }
});

const Tag = sequelize.define('tags', {
  id,
  value: { type: Sequelize.STRING(45), allowNull: false },
});

const Link = sequelize.define('links', {
  id,
  'document_id': { type: Sequelize.INTEGER, allowNull: false },
  'tag_id':      { type: Sequelize.INTEGER, allowNull: false },
});

```

Після того, як сутності задані, час налаштувати зв'язки.
Ця модель документів і даних, які з ними асоціюються, має такий вигляд:

- Документи-метаданні : один-багато;
- Документи-теги: багато-багато, через links;

Для задання цих зв'язків, в Sequelize існують такі ассоціації:
- BelongsTo
- HasOne
- HasMany
- BelongsToMany

Детальніше про них можна почитати [тут](https://sequelize.org/v5/manual/associations.html).

При заданні ассоціацій, важливо пам'ятати джерело та призначення. Наприклад, якщо зв'язок документи-метаданні звучить як один до багатьох, то:
1. Документи МАЮТЬ БАГАТО метаданних (HasMany);
2. Метаданні НАЛЕЖАТЬ ОДНОМУ документу (BelongsTo);

Така асоціація задаватиметься таким чином:
```js
Document.hasMany(Metadata, {
  foreignKey: 'document_id',
  as: 'metadata',
});

Metadata.belongsTo(Document, {
  foreignKey: 'document_id',
  as: 'document',
});
```
Важливо, зв'язок повинен бути двостороннім, тоді із сутностей metadata можна буде достукатись до сутностей Document і навпаки.

Тут в параметрах вказуються ключі, за якими будуть зв'язуватись сутності, та ім'я, через яке потім до сутностей можна достукатись. Наприклад, до метаданних документів можна буде достукатись через властивість `.metadata`:
```js
const doc = /*Екземпляр класа Document*/;
doc.metadata; // масив екземплярів класа Metadata
```

Ассоціація багато-до-багатьох задається так:
1. Документи НАЛЕЖАТЬ БАГАТЬОМ тегам.
2. Теги НАЛЕЖАТЬ БАГАТЬОМ документам.

Така асоціація задаватиметься:
```js
  Document.belongsToMany(Tag, {
    foreignKey: 'document_id',
    through: 'links'
  });

  Tag.belongsToMany(Document, {
    foreignKey: 'tag_id',
    through: 'links'
  });
```

Тут вказується сутність-зв'язка links та ключі, якими зв'язуються.

Повний варіант коду:
```js

// Метаданні
Document.hasMany(Metadata, {
  foreignKey: 'document_id',
  as: 'metadata',
});

Metadata.belongsTo(Document, {
  foreignKey: 'document_id',
  as: 'document',
});

// Теги
Document.belongsToMany(Tag, {
  foreignKey: 'document_id',
  through: 'links'
});

Tag.belongsToMany(Document, {
  foreignKey: 'tag_id',
  through: 'links'
});

```

## 5.2 Запити
Коли всі моделі створені і зв'язки встановленні, час для запитів.

Найпростіший запит це вибрати всі:
```js
  const docs = await Document.findAll();
  console.log(docs); // Масив екземплярів класа Document
```
При цьому є дві проблеми:
1. Об'єкти які повернуться, матимуть багато метаданних запиту.
2. Зв'язків, таких як метаданні і теги не буде.

Перша вирішується методом `get` об'єктів:
```js
  console.log(docs.map(doc => doc.get({ plain: true })));
```

Друга вирішується запитами з параметром include:
```js
  const docs = await Document.findAll({
    include: [
      { model: Metadata, as: 'metadata' },
      { model: Tag, as: 'tags' },
    ];
  });
```

Тепер `docs` це масив документів з метаданними і тегами.
```js
docs[0].metadata // метаданні першого документа
```

Тепер, по цьому шаблону можна робити різноманітні запити, наприклад:
```js

// Знайти за ідентифікатором
const getDocumentById = async id => {
  const include = include: [
      { model: Metadata, as: 'metadata' },
      { model: Tag, as: 'tags' },
    ];
  return Document.findByPk(id, { include });
};

// Знайти за метаданними
const getDocumentByMetadata = async ({ key, value }) => Document.findAll({
  include: [
    { model: Metadata,
      as: 'metadata',
      where: { keyy: key, value }
    },
    { model: docs.db.models.tags, as: 'tags' }
  ],
});
/*
await getByDocumentMetadata({ key: 'publisher, value: 'Elsevier' }) =>
[
  {
    id: 2,
    metadata: [ { id: 7, document_id: 2, keyy: 'publisher', value: 'Elsevier' } ],
    tags: [
      {
        id: 1,
        value: 'Database',
        links: { id: 4, document_id: 2, tag_id: 1 }
      },
      {
        id: 2,
        value: 'Relational',
        links: { id: 5, document_id: 2, tag_id: 2 }
      },
      {
        id: 5,
        value: 'Database Theory',
        links: { id: 6, document_id: 2, tag_id: 5 }
      }
    ]
  }
]
*/

// Створення тегів, якщо їх досі немає
const createTagsIfDontExist = async tagValues => Tag.bulkCreate(tagValues, {
  fields: ['value'],
  updateOnDuplicate: ['value'] // If duplicate error just update
});

// Створення документів
const addDocument = async doc => {
  await createTagsIfDontExistgetOrCreate(doc.tags); // Створити всі теги

  const tags = models.tags.findAll({
    where: { value: { [Sequlize.Op.in]: values } }
  }); // Вибрати теги 
  const include = [{ model: models.metadata, as: 'metadata' }];

  // Створеня документа
  const document = await this.db.models.documents.create(doc, { include });

  // Присвоювання тегів
  await document.setTags(tags);
  return document;
};

// Видалення документа за ідентифікатором
const delDocument = async id => getDocumentById(id).destroy();

```
Більше про типи запитів і можливості можна глянути [тут](https://sequelize.org/v5/index.html).
