# ERD
**Тема:** Електронний реєстр документів

**Група:** ІП-83

**Команда:** Сергійчук Назар, Карпюк Ігор, Євтушенко Георгій, Щелконогова Марина, Леут Марія

# Встановлення
## Ініціалізація репозиторію:
```bash
$ git clone https://github.com/G1gg1L3s/ERD.git
$ cd ERD
$ npm i
```

## Встановлення бази данних

Створення тестового користувача та бази данних:
```bash
$ mysql --user=root --password -s < src/sql/ddl/install.sql
```
Після цього в системі повинен з'явитися користувач з ім'ям `erd_test` і паролем `test`, а також нова база данних `erd`.

Ініціалізація таблиць:
```bash
$ mysql erd --user=erd_test --password=test < src/sql/ddl/create.sql
```

Наповнення данними:
```bash
$ mysql erd --user=erd_test --password=test < src/sql/ddl/data.sql
```

Для перевірки з'єднання з базою данних:
```bash
$ node test/connect.js
```

# Приклади
Всі приклади роботи з моделями лежать у каталозі `examples`. Для запуску:
```bash
$ node examples/documents.js
```