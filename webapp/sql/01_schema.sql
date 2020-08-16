use `isutrain`;

DROP TABLE IF EXISTS `distance_fare_master`;
CREATE TABLE `distance_fare_master` (
  `distance` double NOT NULL,
  `fare` int unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `fare_master`;
CREATE TABLE `fare_master` (
  `train_class` varchar(100) NOT NULL,
  `seat_class` enum('premium', 'reserved', 'non-reserved') NOT NULL,
  `start_date` datetime NOT NULL,
  `fare_multiplier` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations` (
  `reservation_id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` bigint NOT NULL,
  `date` datetime NOT NULL,
  `train_class` varchar(100) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  `departure` varchar(100) NOT NULL,
  `arrival` varchar(100) NOT NULL,
  `status` enum('requesting', 'done', 'rejected') NOT NULL,
  `payment_id` varchar(100) NOT NULL,
  `adult` int NOT NULL,
  `child` int NOT NULL,
  `amount` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `seat_master`;
CREATE TABLE `seat_master` (
  `train_class` varchar(100) NOT NULL,
  `car_number` int(11) NOT NULL,
  `seat_column` enum('A', 'B', 'C', 'D', 'E') NOT NULL,
  `seat_row` int(11) NOT NULL,
  `seat_class` enum('premium', 'reserved', 'non-reserved') NOT NULL,
  `is_smoking_seat` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `seat_reservations`;
CREATE TABLE `seat_reservations` (
  `reservation_id` bigint NOT NULL,
  `car_number` int unsigned NOT NULL,
  `seat_row` int unsigned NOT NULL,
  `seat_column` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_master`;
CREATE TABLE `station_master` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `distance` double NOT NULL,
  `name` varchar(100) NOT NULL UNIQUE,
  `is_stop_express` tinyint(1) NOT NULL,
  `is_stop_semi_express` tinyint(1) NOT NULL,
  `is_stop_local` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `train_master`;
CREATE TABLE `train_master` (
  `date` date NOT NULL,
  `departure_at` time NOT NULL,
  `train_class` varchar(100) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  `start_station` varchar(100) NOT NULL,
  `last_station` varchar(100) NOT NULL,
  `is_nobori` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `train_timetable_master`;
CREATE TABLE `train_timetable_master` (
  `date` date NOT NULL,
  `train_class` varchar(100) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  `station` varchar(100) NOT NULL,
  `departure` time NOT NULL,
  `arrival` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(300) NOT NULL UNIQUE,
  `salt` varbinary(1024) NOT NULL,
  `super_secure_password` varbinary(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE INDEX `date_train_class_train_name_station_on_train_timetable_master`
-- ON train_timetable_master(
--     `date`,
--     `train_class`,
--     `train_name`,
--     `station`
-- );

CREATE INDEX `station_on_train_timetable_master`
ON train_timetable_master(
    `station`,
    `date`
);


CREATE INDEX `date_train_class_train_name_on_reservations`
ON reservations(
    `date`,
    `train_name`,
    `train_class`
);


CREATE INDEX `train_class_car_number_seat_row_seat_column_on_seat_master`
ON seat_master(
    `train_class`,
    `car_number`,
    `seat_row`,
    `seat_column`
);

CREATE INDEX `date_train_class_train_name_on_train_master`
ON train_master(
    `date`,
    `train_class`,
    `train_name`
);

CREATE INDEX `name_on_station` ON station_master(`name`);

CREATE INDEX `start_date_on_fare_master` ON fare_master(`start_date`);

-- CREATE INDEX `distance_on_distance_fare_master` ON distance_fare_master(`distance`);

-- CREATE INDEX `station_date_on_train_timetable_master` ON train_timetable_master(`station`, `date`);

