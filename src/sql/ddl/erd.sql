DROP SCHEMA IF EXISTS erd;
CREATE SCHEMA IF NOT EXISTS erd;

/*DATA STRUCTURIZATION*/

DROP TABLE IF EXISTS erd.documents;
CREATE TABLE IF NOT EXISTS erd.documents (
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id)
);
DROP TABLE IF EXISTS erd.metadata;
CREATE TABLE IF NOT EXISTS erd.metadata (
	document INT NULL,
	keyy VARCHAR(45) NULL,
    value VARCHAR(45) NULL,
    CONSTRAINT document_metadata
		FOREIGN KEY(document)
        REFERENCES erd.documents(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS erd.tags;
CREATE TABLE IF NOT EXISTS erd.tags (
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
	value VARCHAR(45) NULL
);

DROP TABLE IF EXISTS erd.links;
CREATE TABLE IF NOT EXISTS erd.links (
	document INT NULL,
    tag int NULL,
    CONSTRAINT document_link
		FOREIGN KEY(document)
        REFERENCES erd.documents(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT tag_link
		FOREIGN KEY(tag)
        REFERENCES erd.tags(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

/*USER PROFILE MANAGEMENT*/

DROP TABLE IF EXISTS erd.users;
CREATE TABLE IF NOT EXISTS erd.users (
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
    name VARCHAR(45) NULL,
    email VARCHAR(45) NULL
);

/*ACCESS POLICY*/

DROP TABLE IF EXISTS erd.roles;
CREATE TABLE IF NOT EXISTS erd.roles(
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
	name VARCHAR(45) NULL,
    description VARCHAR(45) NULL
);

INSERT INTO erd.roles (name, description)
VALUES 
	('admin', 'documents: crud, users: crud, system-info: r'),
	('editor', 'documents: crud, users: -r--, system-info: r'),
    ('viewer', 'documents: cr--, users: -r--, system-info: r'),
    ('guest', 'documents: ----, users: ----, system-info: r');

DROP TABLE IF EXISTS erd.assignments;
CREATE TABLE IF NOT EXISTS erd.assignments(
	user INT NULL,
    role INT NULL,
    CONSTRAINT user_assignment
		FOREIGN KEY(user)
        REFERENCES erd.users(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT role_assignment
		FOREIGN KEY(role)
        REFERENCES erd.roles(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS erd.operation_types;
CREATE TABLE IF NOT EXISTS erd.operation_types(
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
	name VARCHAR(45) NULL
);

INSERT INTO erd.operation_types (name)
VALUES
	('create'),
    ('read'),
    ('update'),
    ('delete');

DROP TABLE IF EXISTS erd.object_types;
CREATE TABLE IF NOT EXISTS erd.object_types(
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
	name VARCHAR(45) NULL
);

INSERT INTO erd.object_types (name)
VALUES
	('document'),
    ('user'),
    ('system-info');

DROP TABLE IF EXISTS erd.request_types;
CREATE TABLE IF NOT EXISTS erd.request_types(
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
	name VARCHAR(45) NULL,
    operation_type INT NULL,
    object_type INT NULL,
    CONSTRAINT operation_request
		FOREIGN KEY(operation_type)
        REFERENCES erd.operation_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT object_request
		FOREIGN KEY(object_type)
        REFERENCES erd.object_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS erd.grants;
CREATE TABLE IF NOT EXISTS erd.grants(
	user INT NULL,
    role INT NULL,
    request_type INT NULL,
    CONSTRAINT user_grant
		FOREIGN KEY(user)
        REFERENCES erd.users(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT role_grant
		FOREIGN KEY(role)
        REFERENCES erd.roles(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT request_grant
		FOREIGN KEY(request_type)
        REFERENCES erd.request_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

/*HISTORY MANAGEMENT*/

DROP TABLE IF EXISTS erd.events;
CREATE TABLE IF NOT EXISTS erd.events (
	id INT NOT NULL AUTO_INCREMENT,
    primary key (id),
    user INT NULL,
    date DATE NULL,
    CONSTRAINT user_event
		FOREIGN KEY(user)
        REFERENCES erd.users(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS erd.extras;
CREATE TABLE IF NOT EXISTS erd.extras (
	event INT NULL,
	keyy VARCHAR(45) NULL,
    value VARCHAR(45) NULL,
    CONSTRAINT event_extra
		FOREIGN KEY(event)
        REFERENCES erd.events(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
