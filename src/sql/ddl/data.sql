-- -----------------------------------------------------
-- Data for table `erd`.`documents`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`documents` (`id`) VALUES (1);
INSERT INTO `erd`.`documents` (`id`) VALUES (2);
INSERT INTO `erd`.`documents` (`id`) VALUES (3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (1, 1, 'name', 'Relational Database: A Practical Foundation for Productivity');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (2, 1, 'author', 'E.F.Codd');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (3, 1, 'location', 'https://doi.org/10.1016/B978-0-934613-53-8.50009-1');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (4, 2, 'name', 'Towards a Logical Reconstruction of Relational Database Theory');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (5, 2, 'author', 'Raymond Reiter');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (6, 2, 'location', 'https://doi.org/10.1016/B978-0-934613-53-8.50025-X');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (7, 2, 'publisher', 'Elsevier');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (8, 3, 'name', 'Elements of Relational Database Theory');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (9, 3, 'author', 'Paris C.KANELLAKIS');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (10, 3, 'location', 'https://doi.org/10.1016/B978-0-444-88074-1.50022-6');
INSERT INTO `erd`.`metadata` (`id`, `document_id`, `keyy`, `value`) VALUES (11, 3, 'date', '1990');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`tags`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (1, 'Database');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (2, 'Relational');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (3, 'Users');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (4, 'Logic');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (5, 'Database Theory');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (6, 'specification component');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (7, 'algebra query language');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`links`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (1, 1, 1);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (2, 1, 2);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (3, 1, 3);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (4, 2, 1);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (5, 2, 2);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (6, 2, 5);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (7, 3, 1);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (8, 3, 2);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (9, 3, 6);
INSERT INTO `erd`.`links` (`id`, `document_id`, `tag_id`) VALUES (10, 3, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`users` (`id`, `name`, `password`, `email`) VALUES (1, 'Marcus', 'marcus', 'marcus@email.com');
INSERT INTO `erd`.`users` (`id`, `name`, `password`, `email`) VALUES (2, 'G1gg1L3s', 'qwerty', 'test@test.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`events`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`events` (`id`, `user_id`, `time`) VALUES (1, 1, '2020-04-28 14:56:20');
INSERT INTO `erd`.`events` (`id`, `user_id`, `time`) VALUES (2, 2, '2020-05-03 12:01:50');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`extras`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`extras` (`id`, `event_id`, `keyy`, `value`) VALUES (1, 1, 'type', '1');
INSERT INTO `erd`.`extras` (`id`, `event_id`, `keyy`, `value`) VALUES (2, 1, 'success', 'true');
INSERT INTO `erd`.`extras` (`id`, `event_id`, `keyy`, `value`) VALUES (3, 2, 'type', '2');
INSERT INTO `erd`.`extras` (`id`, `event_id`, `keyy`, `value`) VALUES (4, 2, 'success', 'false');
INSERT INTO `erd`.`extras` (`id`, `event_id`, `keyy`, `value`) VALUES (5, 2, 'reason', 'Not found');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`object_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`object_types` (`id`, `name`) VALUES (1, 'Document');
INSERT INTO `erd`.`object_types` (`id`, `name`) VALUES (2, 'User');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`operation_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (1, 'Create');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (2, 'Read');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (3, 'Update');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (4, 'Delete');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`request_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`request_types` (`id`, `name`, `object_type`, `operation_type`) VALUES (1, 'Create document', 1, 1);
INSERT INTO `erd`.`request_types` (`id`, `name`, `object_type`, `operation_type`) VALUES (2, 'View document', 1, 2);
INSERT INTO `erd`.`request_types` (`id`, `name`, `object_type`, `operation_type`) VALUES (3, 'Edit document', 1, 3);
INSERT INTO `erd`.`request_types` (`id`, `name`, `object_type`, `operation_type`) VALUES (4, 'Delete document', 1, 4);
INSERT INTO `erd`.`request_types` (`id`, `name`, `object_type`, `operation_type`) VALUES (5, 'Give permissions to user', 2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (1, 'Viewer', NULL);
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (2, 'Editor', NULL);
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (3, 'Guest', NULL);
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (4, 'Admin', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`assignments`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`assignments` (`id`, `user_id`, `role_id`) VALUES (1, 1, 4);
INSERT INTO `erd`.`assignments` (`id`, `user_id`, `role_id`) VALUES (2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`grants`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (1, NULL, 4, 1);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (2, NULL, 4, 2);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (3, NULL, 4, 3);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (4, NULL, 4, 4);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (5, NULL, 4, 5);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (6, NULL, 1, 2);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (7, NULL, 2, 1);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (8, NULL, 2, 2);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (9, NULL, 2, 3);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (10, NULL, 2, 4);
INSERT INTO `erd`.`grants` (`id`, `user_id`, `role_id`, `request_type_id`) VALUES (11, 1, NULL, 5);

COMMIT;
