-- MySQL Workbench Forward Engineering
drop database flyezy;

SET GLOBAL max_connections = 2000; 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema flyezy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flyezy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flyezy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `flyezy` ;

-- -----------------------------------------------------
-- Table `flyezy`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Airline` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Airline_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `fk_Airline_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `phoneNumber` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `Rolesid` INT NOT NULL,
  `Airlineid` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  INDEX `FKAccounts201294` (`Rolesid` ASC) VISIBLE,
  INDEX `FKAccounts898886` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Accounts_Status1_idx` (`Status_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKAccounts201294`
    FOREIGN KEY (`Rolesid`)
    REFERENCES `flyezy`.`Roles` (`id`),
  CONSTRAINT `FKAccounts898886`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Accounts_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flyezy`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `Country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Location_Country1_idx` (`Country_id` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `flyezy`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Airport` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `Locationid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKAirport14562` (`Locationid` ASC) VISIBLE,
  CONSTRAINT `FKAirport14562`
    FOREIGN KEY (`Locationid`)
    REFERENCES `flyezy`.`Location` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Baggages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Baggages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `weight` FLOAT NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `Airlineid` INT NOT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKBaggages227358` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Baggages_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKBaggages227358`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Baggages_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `minimum_order_value` int NOT NULL,
  `date_created` timestamp NOT NULL,
  `valid_until` timestamp NOT NULL,
  `Airline_id` int NOT NULL,
  `Status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Discount_Airline1_idx` (`Airline_id`),
  KEY `fk_Discount_Status1_idx` (`Status_id`),
  CONSTRAINT `fk_Discount_Airline1` FOREIGN KEY (`Airline_id`) REFERENCES `Airline` (`id`),
  CONSTRAINT `fk_Discount_Status1` FOREIGN KEY (`Status_id`) REFERENCES `Status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Payment_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Payment_Types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `contactName` VARCHAR(45) NOT NULL,
  `contactPhone` VARCHAR(45) NOT NULL,
  `contactEmail` VARCHAR(45) NOT NULL,
  `totalPrice` INT NOT NULL,
  `Accounts_id` INT NULL,
  `Payment_Types_id` INT NULL,
  `paymentTime` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL,
  `Discount_id` INT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Order_Accounts1_idx` (`Accounts_id` ASC) VISIBLE,
  INDEX `fk_Order_Payment_Types1_idx` (`Payment_Types_id` ASC) VISIBLE,
  INDEX `fk_Order_Discount1_idx` (`Discount_id` ASC) VISIBLE,
  INDEX `fk_Order_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Accounts1`
    FOREIGN KEY (`Accounts_id`)
    REFERENCES `flyezy`.`Accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Payment_Types1`
    FOREIGN KEY (`Payment_Types_id`)
    REFERENCES `flyezy`.`Payment_Types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Discount1`
    FOREIGN KEY (`Discount_id`)
    REFERENCES `flyezy`.`Discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flyezy`.`Feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Feedbacks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Accountsid` INT NOT NULL,
  `ratedStar` INT NULL DEFAULT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  `date` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `Statusid` INT NOT NULL,
  `Order_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKFeedbacks957463` (`Accountsid` ASC) VISIBLE,
  INDEX `FKFeedbacks883062` (`Statusid` ASC) VISIBLE,
  INDEX `fk_Feedbacks_Order1_idx` (`Order_id` ASC) VISIBLE,
  CONSTRAINT `FKFeedbacks883062`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`),
  CONSTRAINT `FKFeedbacks957463`
    FOREIGN KEY (`Accountsid`)
    REFERENCES `flyezy`.`Accounts` (`id`),
  CONSTRAINT `fk_Feedbacks_Order1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `flyezy`.`Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight` (
  `id` int NOT NULL AUTO_INCREMENT,
  `minutes` int DEFAULT NULL,
  `departureAirportid` int NOT NULL,
  `destinationAirportid` int NOT NULL,
  `Status_id` int NOT NULL,
  `Airline_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFlight90325` (`departureAirportid`),
  KEY `FKFlight563127` (`destinationAirportid`),
  KEY `fk_Flight_Status1_idx` (`Status_id`),
  KEY `fk_Flight_Airline1_idx` (`Airline_id`),
  CONSTRAINT `fk_Flight_Airline1` FOREIGN KEY (`Airline_id`) REFERENCES `Airline` (`id`),
  CONSTRAINT `fk_Flight_Status1` FOREIGN KEY (`Status_id`) REFERENCES `Status` (`id`),
  CONSTRAINT `FKFlight563127` FOREIGN KEY (`destinationAirportid`) REFERENCES `Airport` (`id`),
  CONSTRAINT `FKFlight90325` FOREIGN KEY (`departureAirportid`) REFERENCES `Airport` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Plane_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Plane_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `Airlineid` INT NOT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKPlane_Cate276706` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Plane_Category_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKPlane_Cate276706`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Plane_Category_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Flight_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight_Detail` (
 `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `price` int DEFAULT NULL,
  `Flightid` int NOT NULL,
  `Plane_Categoryid` int NOT NULL,
  `Status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFlight_Det484575` (`Flightid`),
  KEY `FKFlight_Det564449` (`Plane_Categoryid`),
  KEY `fk_Flight_Detail_Status1_idx` (`Status_id`),
  CONSTRAINT `fk_Flight_Detail_Status1` FOREIGN KEY (`Status_id`) REFERENCES `Status` (`id`),
  CONSTRAINT `FKFlight_Det484575` FOREIGN KEY (`Flightid`) REFERENCES `Flight` (`id`),
  CONSTRAINT `FKFlight_Det564449` FOREIGN KEY (`Plane_Categoryid`) REFERENCES `Plane_Category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `flyezy`.`Flight_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight_Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`News_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`News_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`News`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`News` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL,
  `content` TEXT NULL DEFAULT NULL,
  `News_Categoryid` INT NOT NULL,
  `Accountsid` INT NOT NULL,
  `Airline_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKNews232818` (`News_Categoryid` ASC) VISIBLE,
  INDEX `FKNews924154` (`Accountsid` ASC) VISIBLE,
  INDEX `fk_News_Airline1_idx` (`Airline_id` ASC) VISIBLE,
  CONSTRAINT `FKNews232818`
    FOREIGN KEY (`News_Categoryid`)
    REFERENCES `flyezy`.`News_Category` (`id`),
  CONSTRAINT `FKNews924154`
    FOREIGN KEY (`Accountsid`)
    REFERENCES `flyezy`.`Accounts` (`id`),
  CONSTRAINT `fk_News_Airline1`
    FOREIGN KEY (`Airline_id`)
    REFERENCES `flyezy`.`Airline` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Passenger_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Passenger_Types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Seat_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Seat_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `numberOfSeat` INT NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `Plane_Categoryid` INT NOT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `seatEachRow` INT NOT NULL,
  `surcharge` FLOAT NOT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKSeat_Categ529738` (`Plane_Categoryid` ASC) VISIBLE,
  INDEX `fk_Seat_Category_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKSeat_Categ529738`
    FOREIGN KEY (`Plane_Categoryid`)
    REFERENCES `flyezy`.`Plane_Category` (`id`),
  CONSTRAINT `fk_Seat_Category_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Seat_Categoryid` INT NOT NULL,
  `Passenger_Typesid` INT NULL,
  `code` VARCHAR(255) NULL,
  `pName` VARCHAR(255) NULL,
  `pSex` BIT(1) NULL,
  `pPhoneNumber` VARCHAR(10) NULL,
  `pDob` DATE NULL,
  `Baggagesid` INT NULL DEFAULT NULL,
  `totalPrice` INT NULL,
  `Order_id` INT NULL,
  `Statusid` INT NOT NULL,
  `Flight_Type_id` INT NULL,
  `Flight_Detail_id` INT NOT NULL,
  `cancelled_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKTicket339557` (`Passenger_Typesid` ASC) VISIBLE,
  INDEX `FKTicket999927` (`Baggagesid` ASC) VISIBLE,
  INDEX `FKTicket721068` (`Seat_Categoryid` ASC) VISIBLE,
  INDEX `FKTicket601957` (`Statusid` ASC) VISIBLE,
  INDEX `fk_Ticket_Order1_idx` (`Order_id` ASC) VISIBLE,
  INDEX `fk_Ticket_Flight_Type1_idx` (`Flight_Type_id` ASC) VISIBLE,
  INDEX `fk_Ticket_Flight_Detail1_idx` (`Flight_Detail_id` ASC) VISIBLE,
  CONSTRAINT `FKTicket339557`
    FOREIGN KEY (`Passenger_Typesid`)
    REFERENCES `flyezy`.`Passenger_Types` (`id`),
  CONSTRAINT `FKTicket601957`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`),
  CONSTRAINT `FKTicket721068`
    FOREIGN KEY (`Seat_Categoryid`)
    REFERENCES `flyezy`.`Seat_Category` (`id`),
  CONSTRAINT `FKTicket999927`
    FOREIGN KEY (`Baggagesid`)
    REFERENCES `flyezy`.`Baggages` (`id`),
  CONSTRAINT `fk_Ticket_Order1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `flyezy`.`Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Flight_Type1`
    FOREIGN KEY (`Flight_Type_id`)
    REFERENCES `flyezy`.`Flight_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Flight_Detail1`
    FOREIGN KEY (`Flight_Detail_id`)
    REFERENCES `flyezy`.`Flight_Detail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Refund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Refund` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bank` VARCHAR(255) NULL DEFAULT NULL,
  `bankAccount` VARCHAR(255) NULL DEFAULT NULL,
  `requestDate` TIMESTAMP NULL,
  `refundDate` TIMESTAMP NULL,
  `refundPrice` INT NULL,
  `Ticketid` INT NOT NULL,
  `Statusid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKRefund25985` (`Ticketid` ASC) VISIBLE,
  INDEX `FKRefund748756` (`Statusid` ASC) VISIBLE,
  CONSTRAINT `FKRefund25985`
    FOREIGN KEY (`Ticketid`)
    REFERENCES `flyezy`.`Ticket` (`id`),
  CONSTRAINT `FKRefund748756`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- ------------------------------------------------
-- INSERT DATA
---------------------------------------------------
INSERT INTO `Status` VALUES 
(1,'Activated'),(2,'Deactivated'),(3,'Is Processing'),
(4,'Accepted'),(5,'Rejected'),(6,'Cancellation Request'),
(7,'Is Cancelled'),(8,'Refund Completed'),(9,'Is Empty'),
(10,'Successful Payment'),(11,'Cancellation Rejection'), (12, 'Is Pending'),
(13, 'Refund Pending'),(14, 'Refund Rejected');

INSERT INTO `Roles` VALUES 
(1,'Admin'),
(2,'Airline Staff'),
(3,'Member'),
(4,'Service Staff');

INSERT INTO `Airline` VALUES 
(1,'FLYEZY','img/flyezy-logo.png',NULL, 1),
(2,'Vietnam Airline','img/vietnam-airline.png',NULL, 1),
(3,'Bamboo Airway','img/bamboo-airway.png',NULL, 1),
(4,'Vietjet Air','img/vietjet.jpg',NULL, 1);

INSERT INTO `Baggages` VALUES (4,10,180000,3,1),(5,20,310000,3,1),(6,30,440000,3,1),(7,40,570000,3,1),(8,50,700000,3,1),(9,60,830000,3,1),(10,20,266000,4,1),(11,30,374000,4,1),(12,40,482000,4,1),(13,50,644000,4,1),(14,60,752000,4,1),(15,70,860000,4,1),(16,10,200000,2,1),(17,20,350000,2,1),(18,30,500000,2,1);

INSERT INTO `Accounts` 
VALUES (1,'Ngô Tùng Dương','duongnthe186310@fpt.edu.vn','37oBLppg5fQlddjpE9wLCw==','0862521226','','img/avatar.jpg','2004-11-16',1,1,'2024-09-23 14:07:56','2024-09-23 14:20:15',1),
(2,'Vietnam Airline Staff','airline@gmail.com','btNZZvRyFKU3BVf15/ieU326M0db7YwFkl7FCl+qslw=','0111111111','','img/vietnam-airline.png','2024-09-18',2,2,'2024-09-23 14:19:19',NULL,1),
(3,'Bamboo Staff','bamboo@gmail.com','k3xGFrEqEnbaMspVYy9wzQ==','0222222222','','img/bamboo-airway.png','2024-09-19',2,3,'2024-09-24 14:19:19',NULL,1),
(4,'Service Staff','flyfly@gmail.com','4mnCBFFCwFuye0oGDitxkG+mlIbdDlvvOj55UvbHKy0=','0444444444','','img/jack.png','1994-09-19',4,1,'2024-09-24 14:19:19',NULL,1),
(5,'Sơn Tùng MTP','td2k416@gmail.com','ep9TogRphbhALmP7tn8/RA==','0938273888','Thái Bình','img/mtp.jpg','1994-07-05',3,1,'2024-11-02 11:32:45',NULL,1),
(6,'Vietjet Air Staff','vietjet@gmail.com','9l4qgVnQ2o4bvRkdB216pQ==','0333333333','','img/vietjet.jpg','2004-05-05',2,4,'2024-11-05 11:12:46',NULL,1);


INSERT INTO `Plane_Category` 
VALUES (1,'Airbus A321CEO','img/Airbus A321CEO.png',3,NULL,1),
(2,'Airbus A320NEO','img/Airbus A320NEO.png',3,NULL,1),
(3,'Airbus A320CEO','img/Airbus A320CEO.png',3,NULL,1),
(4,'Airbus A321','img/vnairline-AIRBUS A321.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 5.600 km</p><p>Vận tốc (km/h): 950 km/h</p><p>Số ghế (*): 184</p><p>Tổng chiều dài: 44,51 m</p><p>Sải cánh: 34,1 m</p><p>Chiều cao: 11,76 m</p>',1),
(5,'BOEING 787','img/vnairline-BOEING 787.png',2,'<p>Nhà sản xuất: Boeing</p><p>Khoảng cách tối đa (km): 15.750 km</p><p>Vận tốc (km/h): 954 km/h</p><p>Tổng chiều dài: 63.73 m</p><p>Sải cánh: 60.93 m</p><p>Chiều cao: 18.76 m</p>',1),
(6,'AIRBUS A350','img/vnairline-AIRBUS A350.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 14.350 km</p><p>Vận tốc (km/h): 901 km/h</p><p>Tổng chiều dài: 66.89 m</p><p>Sải cánh: 64.75 m</p><p>Chiều cao: 17.05 m</p>',1),
(7,'AIRBUS A320 NEO','img/vnairline-AIRBUS A320 NEO.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 6.300 km</p><p>Vận tốc (km/h): 1.005 km/h</p><p>Tổng chiều dài: 37,57 m</p><p>Sải cánh: 35,8 m</p><p>Chiều cao: 11,76 m</p>',1),
(13,'Airbus A330','img/vietjetair-airbusA330.jpg',4,'<ul><li><strong>Maximum Distance (km):</strong> 11,750&nbsp;km</li><li><strong>Total Length:</strong> 63.6&nbsp;m</li><li><strong>Speed ​​(km/h):</strong> 871&nbsp;km/h</li><li><strong>Wingspan:</strong> 60.3&nbsp;m</li><li><strong>Number of Seats: </strong>375</li><li><strong>Height:</strong> 16.85&nbsp;m</li></ul>',1),
(14,'Airbus A321','img/vietjetair-airbusA321.jpg',4,'<ul><li><strong>Maximum Distance (ft):</strong> 39,800</li><li><strong>Overall Length: </strong>44.51 m</li><li><strong>Speed ​​(km/h): </strong>876 km/h</li><li><strong>Wingspan:</strong> 35.8 m</li><li><strong>Seats:</strong> 180 – 240</li><li><strong>Height: </strong>11.76 m</li><li>&nbsp;</li></ul>',1),
(15,'BOEING 737 Max','img/vietjetair-boeing737Max.jpg',4,'<ul><li><strong>Aircraft Type</strong>: Boeing 737 Max</li><li><strong>Passenger Capacity</strong>: Approximately 190 to 210 seats (depending on configuration)</li><li><strong>Wingspan</strong>: 35.9 meters</li><li><strong>Length</strong>: 39.5 meters</li><li><strong>Maximum Range</strong>: 6,570 km</li><li><strong>Engine</strong>: Equipped with fuel-efficient, quieter engines that are more environmentally friendly compared to older models</li></ul>',1);

INSERT INTO `Seat_Category` 
VALUES (1,'Economy',184,'img/bamboo-economy.jpg',1,'<ul><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hành lý xách tay: 7kg</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Thay đổi trước giờ khởi hành: 600.000 VND (*)</span><br><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Không thay đổi sau giờ khởi hành (*)</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hệ số cộng điểm Flyezy Club: 0.25</span></li></ul>',6,0,1),
(2,'Business',8,'img/bamboo-business.jpg',1,'<ul><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hành lý xách tay: 2 kiện, 7kg/kiện</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">01 kiện hành lý ký gửi 40kg</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hoàn/huỷ trước giờ khởi hành: 300.000 VND (*)</span><br><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hoàn/huỷ sau giờ khởi hành: 300.000 VND (*)</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Hệ số cộng điểm Flyezy Club: 2</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Thay đổi miễn phí</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Chọn ghế ngồi miễn phí</span></li><li><span style=\"background-color:rgb(255,255,255);color:rgb(52,64,84);\">Đổi chuyến tại sân bay miễn phí</span></li></ul>',6,0.5,1),
(3,'Economy',168,'img/bamboo-economy.jpg',2,NULL,6,0,1),
(4,'Business',8,'img/bamboo-business.jpg',2,NULL,6,0.5,1),
(5,'Economy',162,'img/bamboo-economy.jpg',3,NULL,6,0,1),
(6,'Business',8,'img/bamboo-business.jpg',3,NULL,6,0.5,1),
(7,'Hạng Phổ Thông',162,'img/vnairline-A321-GhePhoThong.png',4,NULL,6,0,1),
(8,'Hạng Thương Gia',16,'img/vnairline-A321-Business.png',4,'',6,0.5,1),
(9,'Hạng Phổ Thông',211,'img/vnairline-B787-GhePhoThong.png',5,NULL,6,0,1),
(10,'Hạng Phổ Thông Đặc Biệt',35,'img/vnairline-B787-GhePhoThongDacBiet.png',5,NULL,6,0.3,1),
(11,'Hạng Thương Gia',28,'img/vnairline-B787-GheThuongGia.png',5,NULL,6,0.5,1),
(12,'Hạng Phổ Thông',231,'img/vnairline-A350-GhePhoThong.png',6,NULL,6,0,1),
(13,'Hạng Phổ Thông Đặc Biệt',45,'img/vnairline-A350-GhePhoThongDacBiet.png',6,NULL,6,0.3,1),
(14,'Hạng Thương Gia',29,'img/vnairline-A350-GheThuongGia.png',6,NULL,6,0.5,1),
(15,'Hạng Phổ Thông',180,'img/vnairline-A320neo-PhoThong.png',7,NULL,6,0,1),
(16,'Hạng Thương Gia',8,'img/vnairline-A320neo-Thuong gia.png',7,NULL,6,0.5,1),
(20,'Eco',365,'img/vietjetair-airbusA330-eco.jpg',13,'<ul><li>Equipped with leather seats</li><li>Spacious dimensions and noise control technology in the passenger compartment.</li></ul>',9,0,1),
(21,'Skyboss Premier ',12,'img/vietjetair-airbusA330-skyboss.jpg',13,'<ul><li>Equipped with leather seats</li><li>Spacious dimensions and noise control technology in the passenger compartment.</li><li>Spacious and comfortable seating</li><li>Priority check-in and boarding</li><li>Complimentary meal</li><li>VIP lounge access</li><li>&nbsp;</li></ul>',6,0.5,1),
(22,'Eco',78,'img/vietjetair-airbusA321-eco.jpg',14,'<ul><li>Comfortable standard seating</li><li>Basic amenities provided</li><li>Standard baggage allowance</li></ul>',6,0,1),
(23,'Deluxe',108,'img/vietjetair-airbusA321-duluxu.jpg',14,'<ul><li>Located near the emergency exit</li><li>Extra legroom for comfort</li><li>Priority boarding available</li></ul>',6,0.2,1),
(24,'SkyBoss',30,'img/vietjetair-airbusA321-skyboss.jpg',14,'<ul><li>Extra spacious and comfortable</li><li>Priority check-in and boarding</li><li>Complimentary meal and drink</li><li>Increased baggage allowance</li></ul>',6,0.5,1),
(25,'Eco',140,'img/vietjetair-airbusA321-eco.jpg',15,'<ul><li>Comfortable standard seating</li><li>Basic amenities provided</li><li>Standard baggage allowance</li></ul>',6,0,1),
(26,'Deluxu',30,'img/vietjetair-airbusA321-duluxu.jpg',15,'<ul><li>Located near the emergency exit</li><li>Extra legroom for comfort</li><li>Priority boarding available</li></ul>',6,0.2,1),
(27,'SkyBoss',12,'img/vietjetair-airbusA321-skyboss.jpg',15,'<ul><li>Extra spacious and comfortable</li><li>Priority check-in and boarding</li><li>Complimentary meal and drink</li><li>Increased baggage allowance</li></ul>',4,0.5,1);
  
INSERT INTO Country (id,name)
VALUES
    (1,'Việt Nam'),
    (2,'Nhật Bản'),
    (3,'Hàn Quốc');

INSERT INTO Location (id,name, Country_id)
VALUES
    (1,'Hà Nội', 1),
    (2,'TP. Hồ Chí Minh', 1),
    (3,'Tokyo', 2),
    (4,'Osaka', 2),
    (5,'Seoul', 3),
    (6,'Busan', 3);

INSERT INTO Airport (id,name, Locationid)
VALUES
    (1,'Nội Bài International Airport', 1),
    (2,'Tân Sơn Nhất International Airport', 2),
    (3,'Narita International Airport', 3),
    (4,'Kansai International Airport', 4),
    (5,'Incheon International Airport', 5),
    (6,'Gimhae International Airport', 6);

INSERT INTO `flyezy`.`Passenger_Types` (`id`, `name`, `price`)
VALUES 
(1, 'Adult', 1),
(2, 'Children', 0.8),
(3, 'Infant', 0.5);

INSERT INTO `flyezy`.`Payment_Types` (`id`, `name`,`image`)
VALUES 
(1, 'QR Code', null),
(2, 'VNPAY',null);

INSERT INTO `Flight_Type` VALUES (1,'Outbound '),(2,'RT-Outbound'),(3,'RT-Inbound');

INSERT INTO `flyezy`.`News_Category` (`name`) VALUES 
('News'),
('Promotion');

INSERT INTO `Flight` VALUES (1,120,1,2,1,3),(2,120,2,1,1,3),(3,360,1,3,1,3),(4,360,3,1,1,3),(5,360,2,3,1,3),(6,360,3,2,1,3),(7,300,1,4,1,2),(8,300,4,1,1,2),(9,300,2,6,1,2),(10,300,6,2,1,2),(11,120,2,1,1,2),(12,120,1,2,1,4),(13,120,2,1,1,4),(15,120,1,2,1,2);
INSERT INTO `Flight_Detail` VALUES (1,'2024-10-01','14:30:00',1200000,1,1,3),(2,'2024-10-02','15:45:00',1350000,1,2,3),(3,'2024-10-03','10:00:00',1500000,1,3,3),(4,'2024-11-10','12:10:52',1200000,1,1,1),(5,'2024-11-10','01:00:00',1200000,11,4,1),(6,'2024-11-10','22:00:00',1200000,11,4,1),(7,'2024-11-11','09:00:00',1250000,11,4,1),(8,'2024-11-02','12:46:00',1250000,1,1,1),(9,'2024-11-10','00:00:00',1100000,12,14,1),(10,'2024-11-10','13:00:00',1050000,12,15,1),(11,'2024-11-10','14:00:00',1050000,13,14,1),(12,'2024-11-10','09:00:00',1150000,12,15,1),(13,'2024-11-10','02:30:00',1050000,13,15,1),(14,'2024-11-10','11:30:00',1200000,13,15,1),(15,'2024-11-10','15:00:00',1200000,2,1,1),(16,'2024-11-11','05:00:00',1200000,1,1,1),(17,'2024-11-11','07:00:00',1250000,1,2,1),(18,'2024-11-11','08:00:00',1300000,1,3,1),(19,'2024-11-11','14:00:00',1240000,1,1,1),(20,'2024-11-11','16:00:00',1260000,1,1,1),(21,'2024-11-11','02:00:00',1100000,12,14,1),(22,'2024-11-11','06:30:00',1150000,12,15,1),(23,'2024-11-11','22:20:00',1200000,12,14,1),(24,'2024-11-11','23:00:00',1250000,13,14,1),(25,'2024-11-11','07:00:00',1160000,13,14,1),(26,'2024-11-11','10:00:00',1450000,15,5,1),(27,'2024-11-11','16:00:00',1400000,15,4,1),(28,'2024-11-11','09:00:00',1250000,15,4,1),(29,'2024-11-11','23:00:00',1400000,11,4,1),(30,'2024-11-11','10:00:00',2000000,11,4,1),(31,'2024-11-11','15:00:00',1260000,11,5,1),(32,'2024-11-11','22:00:00',1200000,2,1,1),(33,'2024-11-11','14:00:00',1500000,2,2,1);


 INSERT INTO `Discount` VALUES (1,'VNAIRLINE1',10.00,3000000,'2024-11-09 00:00:00','2024-11-12 00:00:00',2,1),(2,'VNAIRLINE2',20.00,5000000,'2024-11-08 00:00:00','2024-11-09 00:00:00',2,1),(3,'BAMBOO0001',10.00,2000000,'2024-11-09 00:00:00','2024-11-12 00:00:00',3,1),(4,'BAMBOO0002',20.00,4000000,'2024-11-06 00:00:00','2024-11-09 00:00:00',3,1);


INSERT INTO `flyezy`.`Order` (`id`, `code`, `contactName`, `contactPhone`, `contactEmail`, `totalPrice`, `Accounts_id`, `Payment_Types_id`, `paymentTime`, `created_at`, `Discount_id`, `Status_id`)
VALUES 
(1,'13NG3UVQ8','Sơn Tùng MTP','0873232111','td2k416@gmail.com',10280000,5,NULL,NULL,'2024-11-02 10:50:24',NULL,12);

INSERT INTO `flyezy`.`Order` (`code`, `contactName`, `contactPhone`, `contactEmail`, `totalPrice`, `created_at`, `Status_id`) VALUES ('MAINTENANCE', 'MAINTENANCE', '0000000000', 'maintenance@gmail.com', '0', '2024-11-02 10:50:24', '12');

INSERT INTO `Ticket` VALUES 
(1,1,1,'B1','Nguyễn Thanh Tùng',1,'1230114182','1994-07-05',4,1380000,1,12,2,4,NULL),
(2,1,1,'A1','Nguyễn Thanh Tùng',1,'1230114182','1994-07-05',16,2000000,1,12,3,15,NULL),
(3,1,1,'C1','Nguyễn Thanh Thanh',1,'1231231231','1995-11-05',NULL,1200000,1,12,2,4,NULL),
(4,1,1,'B1','Nguyễn Thanh Thanh',1,'1231231231','1995-11-05',NULL,1800000,1,12,3,15,NULL),
(5,1,2,'D1','Nguyễn Văn Văn',1,NULL,'2020-12-11',NULL,960000,1,12,2,4,NULL),
(6,1,2,'C1','Nguyễn Văn Văn',1,NULL,'2020-12-11',NULL,1440000,1,12,3,15,NULL),
(7,1,3,NULL,'Nguyễn Baby',1,NULL,'2023-12-11',NULL,600000,1,12,2,4,NULL),
(8,1,3,NULL,'Nguyễn Baby',1,NULL,'2023-12-11',NULL,900000,1,12,3,15,NULL);




INSERT INTO `News` VALUES (1,'Vietjet Travel Safe','img/news_vietjet_1.jpg','<p>Hãng hàng không Vietjet luôn quan tâm và thấu hiểu khách hàng, luôn mong muốn Quý khách có một chuyến đi tốt đẹp. Một chuyến đi mà Quý khách sẽ không phải lo lắng gì trong suốt hành trình. Cho dù là một chuyến du lịch hay công tác, bảo hiểm du lịch phù hợp sẽ là một yếu tố quan trọng mà Quý khách không nên bỏ qua.</p><p>&nbsp;</p><p>Với Vietjet Travel Safe, Quý khách hoàn toàn có thể yên tâm khi đã được bảo vệ tốt nhất trước những trở ngại trong chuyến đi như tai nạn, mất hành lý hoặc giấy tờ tùy thân, bị hủy chuyến bay và những trở ngại khách. Bảo hiểm du lịch Vietjet Travel Safe do Tổng công ty Bảo hiểm Bảo Việt cung cấp trên cơ sở đồng bảo hiểm cùng công ty TNHH Bảo hiểm HD tại <a href=\"https://www.vietjetair.com/vi/pages/vietjetair.com\">vietjetair.com</a></p><p>Để biết thêm thông tin về quyền lợi bảo hiểm của Vietjet Travel Safe, vui lòng xem:</p><ul><li><a href=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/0-document/travelsafe/travel-safe-term-and-condition.pdf\">Vietjet Travel Safe Tóm tắt Quyền lợi bảo hiểm</a></li><li><a href=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/0-document/travelsafe/travel-safe-declaration.pdf\">Vietjet Travel Safe Tuyên bố</a></li><li><a href=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/0-document/travelsafe/travel-safe-policy-vi.pdf\">Vietjet Travel Safe Quy tắc bảo hiểm</a></li></ul><figure class=\"image\"><img style=\"aspect-ratio:855/357;\" src=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/vietjetguid-1688380972051.jpg\" alt=\"\" width=\"855\" height=\"357\"></figure><p>Quý khách có thể nộp hồ sơ yêu cầu bồi thường trực tuyến tại đây hoặc gửi thư điện tử đến Bảo hiểm Bảo Việt theo địa chỉ <a href=\"mailto:insurancehelp@baoviet.com.vn\">insurancehelp@baoviet.com.vn</a> để được hỗ trợ.</p><p>&nbsp;</p><p><a href=\"https://www.vietjetair.com/vi/FAQ/faqs-travel-safe-16883976458321\"><strong>Câu hỏi thường gặp</strong></a></p><p>&nbsp;</p><p><strong>Hướng dẫn lấy hóa đơn Giá trị gia tăng:&nbsp;</strong></p><p>Nếu Quý khách có nhu cầu lấy hóa đơn phí bảo hiểm Vietjet Travel Safe, vui lòng làm theo quy trình sau:</p><ul><li>Trong cùng tháng Giấy chứng nhận bảo hiểm được cấp, khách hàng có yêu cầu xuất hóa đơn bảo hiểm ngay, vui lòng điền và gửi thông tin chi tiết theo mẫu <a href=\"https://docs.google.com/forms/d/1g8M9AAZCtieeRnkwskLGkTPn26HkHdKy__xT2ik9czM/viewform?edit_requested=true\">tại đây</a> tới Bảo hiểm Bảo Việt.</li><li>Sau khi nhận được thông tin yêu cầu xuất hóa đơn, Bảo hiểm Bảo Việt sẽ kiểm tra đối chiếu, xuất và gửi hóa đơn trực tiếp đến địa chỉ email của khách hàng trong vòng 02 ngày làm việc.</li><li>Các khách hàng đã mua bảo hiểm du lịch Vietjet Travel Safe, thông qua các Giao diện Kỹ thuật số thuộc quyền quản lý của Vietjet Air, không yêu cầu xuất hóa đơn bảo hiểm, sẽ được Bảo hiểm Bảo Việt xuất chung trên 1 hóa đơn với tiêu thức “Người mua không yêu cầu hóa đơn”.</li><li>Trường hợp Bảo hiểm Bảo Việt nhận được yêu cầu xuất hóa đơn vào tháng kế tiếp cho những Giấy Chứng Nhận Bảo Hiểm đã cấp của tháng trước đó, Bảo hiểm Bảo Việt sẽ linh động xuất hóa đơn cho những yêu cầu gửi đến Bảo hiểm Bảo Việt trước ngày 5 của tháng kế tiếp.</li></ul><p><i><strong>Lưu ý: </strong>Bảo hiểm Bảo Việt không ủy quyền cho bất kỳ một bên thứ ba nào tư vấn hay xuất hóa đơn Giá trị gia tăng về sản phẩm bảo hiểm Vietjet Travel Safe này. Sản phẩm Bảo hiểm này chỉ được cung cấp thông qua các Giao diện kỹ thuật số thuộc quyền quản lý của Vietjet Air. Nếu Quý khách cần hỗ trợ về sản phẩm Bảo hiểm du lịch Vietjet Travel Safe, vui lòng liên hệ với chúng tôi tại:</i></p><ul><li>Tổng công ty Bảo hiểm Bảo Việt</li><li>Địa chỉ: số 7 Lý Thường Kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, Hà Nội, Việt Nam</li><li>Hotline: 1900 55 88 99</li><li>Email: <a href=\"mailto:insurancehelp@baoviet.com.vn\">insurancehelp@baoviet.com.vn</a></li><li>Giờ mở cửa:<ul><li>Từ Thứ hai đến Thứ sáu</li><li>08:00 sáng đến 05:00 chiều</li></ul></li></ul>',1,6,4),(2,'Vietnam Airlines Celebrates 30 Years of Nonstop Service and Welcomes Its 15 Millionth Passenger on Routes Between Vietnam and the Republic of Korea','img/news_vnairline_1.jpg','<p><strong>Vietnam Airlines celebrated the 30th anniversary of its nonstop service between Vietnam and the Republic of Korea (RoK) and welcomed the 15 millionth passenger. The airline also signed agreements with Korean partners during the official visit to the RoK of Prime Minister Pham Minh Chinh and the Vietnamese high-ranking delegation.</strong></p><p><strong>BÀI VIẾT LIÊN QUAN</strong></p><ul><li><a href=\"https://spirit.vietnamairlines.com/english/vietnam-airlines-to-receive-new-aircraft-and-extend-international-flight-network.html\">Vietnam Airlines to Receive New Aircraft and Extend International Flight Network</a></li><li><a href=\"https://spirit.vietnamairlines.com/chuyen-dong-vna/vietnam-airlines-ky-niem-30-nam-duong-bay-thang-va-chao-don-hanh-khach-thu-15-trieu-giua-viet-nam-han-quoc.html\">Vietnam Airlines kỷ niệm 30 năm đường bay thẳng và chào đón hành khách thứ 15 triệu giữa Việt Nam – Hàn Quốc</a></li></ul><p>Vietnam Airlines’ entry into the RoK started with the first direct flight linking Ho Chi Minh City and Seoul. This route has not only provided a convenient connectivity but also significantly fostered trade, commercial and cultural ties between the two countries.</p><p>The airline currently serves six direct routes including Hanoi and Ho Chi Minh City to Seoul and Busan; Da Nang and Cam Ranh to Seoul, with an average frequency of 112 flights per week. Vietnam Airlines is also the first and only airline in Vietnam to operate state-of-the-art fleet on these flights such as the Airbus A350 and Boeing 787, allowing passengers to travel in style and comfort.</p><p>Over the past three decades, Vietnam Airlines has operated 65,000 flights with 15 million passengers and 291,300 tons of cargo between Vietnam and the RoK. Before Covid19, the annual growth rate in passenger numbers reached 26% with a total of about 1.3 million passengers in 2019. Despite the unprecedented impact of the pandemic, the airline&nbsp; returned to pre-pandemic levels and witnessed major leaps in 2023 as shown by 562,000 passengers transported in the five months of 2024.</p><p style=\"text-align:center;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners.jpg\" alt=\"\" srcset=\"https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners.jpg 2000w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners-768x512.jpg 768w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners-1536x1024.jpg 1536w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners-750x500.jpg 750w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/1.1.-Agreement-Exchange-Ceremony-for-Memorandum-of-Understanding-between-Vietnam-Airlines-and-Korean-partners-1140x760.jpg 1140w\" sizes=\"100vw\" width=\"2000\" height=\"1333\">Agreement Exchange Ceremony for Memorandum of Understanding between Vietnam Airlines and Korean partners. (Photo: VNA)</p><p>Dang Ngoc Hoa, Chairman of Vietnam Airlines, said that the achievement over the past three decades underscores Vietnam Airlines’ deep commitment to the RoK – a strategically important route. “We will continue to focus on our network expansion, fleet modernization and ramp up operations in the RoK, and especially elevate service quality at every touchpoint. Our vision is to constantly strengthen cooperation and partnerships with airlines, partners, and stakeholders in the RoK.”, shared Dang Ngoc Hoa.</p><p>As part of the Prime Minister’s visit, Vietnam Airlines signed a Memorandum of Understanding (MOU) with Korean Air and travel companies in the RoK. Under the agreement, both sides will promote bilateral investment and tourism, further complementing the strengths in advertising, marketing, and the creation of aviation products and services.</p><p>Vietnam Airlines’ direct flights to the RoK have contributed to economic growth, tourism, and cultural exchanges. The two nations upgraded their bilateral relation to a Comprehensive strategic partnership in 2022.</p><p style=\"text-align:center;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK.jpg\" alt=\"\" srcset=\"https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK.jpg 4919w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK-768x511.jpg 768w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK-1536x1021.jpg 1536w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK-2048x1362.jpg 2048w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK-750x499.jpg 750w, https://spirit.vietnamairlines.com/wp-content/uploads/2024/07/2.-Vietnam-Airlines-Celebrates-30-Years-of-Direct-Flights-and-Welcomes-15-Millionth-Passenger-on-Routes-Between-Vietnam-and-the-ROK-1140x758.jpg 1140w\" sizes=\"100vw\" width=\"4919\" height=\"3271\">Vietnam Airlines Celebrates 30 Years of Direct Flights and Welcomes 15 Millionth Passenger on Routes Between Vietnam and the ROK. (Photo: VNA)</p><p>Since the direct route’s establishment, the RoK has emerged as one of Vietnam’s international markets with the most rapid growth with an average annual growth rate of 22% before the pandemic. In 2019, 9.65 million passengers traveled between the two countries. In 2023, this number has recovered to 85% of 2019 levels at 8.25 million. In the first five months of 2024, 4.4 million passengers traveled by air between the two countries. Vietnam offers tourists a unique set of characteristics and is a top-of-mind destination for Korean tourists, while the RoK continues to attract Vietnamese people to visit for leisure purposes, study, and work.</p>',1,2,2),(3,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',1,3,3),(4,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_2.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',1,3,3),(5,'Vietnam Airlines awarded at Skyteam Sustainable Flight Challenge','img/news_vnairline_2.jpg','<p><strong>Skyteam unveiled winners of The Sustainable Flight Challenge – the industry-first sustainability initiative – at an awards event held in Atlanta. Vietnam Airlines won the subcategory award “Boldest Move”, highlighting its efforts and creativity by providing unused, quality inflight food such as cereal, snack…to VietHarvest. Following strict processes to ensure quality, the foodd will then be redistributed to the communities in need in Vietnam.</strong></p><p><strong>BÀI VIẾT LIÊN QUAN</strong></p><p>&nbsp;</p><p style=\"text-align:center;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40.jpg\" alt=\"\" srcset=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40.jpg 1960w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40-768x513.jpg 768w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40-1536x1026.jpg 1536w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40-750x501.jpg 750w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/IMG-1FF4B3CB-1B9A-4261-A8DE-DE05FFD98D40-1140x761.jpg 1140w\" sizes=\"100vw\" width=\"1960\" height=\"1309\"><i>Vietnam Airlines won the subcategory award “Boldest Move”.</i></p><p>VietHarvest is an innovative new social enterprise that launched in June 2022 that collects quality surplus food and redistributes it to underserved communities in Vietnam. This solution has been implemented on all Vietnam Airlines flights over the past 3 months. The airline was also in the top 3 airlines with the best Cleaning Waste Management solution.</p><p style=\"text-align:center;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1.jpg\" alt=\"\" srcset=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1.jpg 2048w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1-768x512.jpg 768w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1-1536x1024.jpg 1536w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1-750x500.jpg 750w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/1.-Cac-suat-an-duoc-quyen-gop-se-thuc-hien-theo-quy-trinh-thu-hoi-kiem-tra-phan-loai-va-luu-tru-rieng-biet-de-dam-bao-chat-luong-cua-san-pham-khi-chuyen-giao-cho-VietHarvest-1-1140x760.jpg 1140w\" sizes=\"100vw\" width=\"2048\" height=\"1365\"><i>Illustrative image.</i></p><p>Launched in 2022, The Sustainable Flight Challenge (TSFC) harnesses the power of friendly competition to spark new innovations to help reduce air travel’s footprint. This year, 22 airlines operated a total of 72 flights – 50 more than in 2022 – and submitted more than 350 new ideas that will be shared across the industry. Award submissions were evaluated by a diverse jury of international aviation and sustainability experts who decided the winners of the 25 subcategories and seven overall awards from the Royal Netherlands Aerospace Center and PA Consulting.</p><p>Dang Anh Tuan, Executive Vice President of Vietnam Airlines said: “This award illustrates Vietnam Airlines’ commitment in reducing food waste, hunger and poverty and creating a sustainable food culture and eco-system in Vietnam. Not only do we raise awareness and explore innovative approaches, we hope to continue to join forces with airlines worldwide to reshape the future of aviation and advance the industry’s goal of achieving net-zero emissions by 2050.”</p><p style=\"text-align:center;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1.jpg\" alt=\"\" srcset=\"https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1.jpg 2048w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1-768x512.jpg 768w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1-1536x1024.jpg 1536w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1-750x500.jpg 750w, https://spirit.vietnamairlines.com/wp-content/uploads/2023/10/3.-Vietnam-Airlines-ban-giao-cho-VietHarvest-thuc-pham-kho-nhu-goi-hat-rang-banh-dong-goi-cac-loai-hop-ngu-coc-de-chuyen-toi-cac-to-chuc-ca-nhan-co-hoan-canh-kho-khan-1-1140x760.jpg 1140w\" sizes=\"100vw\" width=\"2048\" height=\"1365\"><i>VietHarvest is an innovative new social enterprise that launched in June 2022 that collects quality surplus food and redistributes it to underserved communities in Vietnam.</i></p><p>Previously, in May 2023, Vietnam Airlines completed the long-haul flight VN37 from Hanoi to Frankfurt (Germany) as part of SkyTeam’s Sustainable Flight Challenge, aiming to encourage global airlines to find innovative ways to make air travel greener.&nbsp;</p><p>From unusable vests that no longer meet safety requirements, Vietnam Airlines joined hands with social enterprise Limloop to recycle hundreds of unusable life vests into handbags for passengers. Vietnam Airlines also served a sustainable inflight meal on the special flight, using seasonal ingredients and alternative plant-based protein source from sustainably grown soybeans through partnership with the US Soybean Export Council (USSEC).</p>',1,2,2),(6,'Đón mùa lễ hội cuối năm, Vietjet mở lại loạt đường bay đến Đà Nẵng, Đà Lạt, Phú Quốc, Cần Thơ phục vụ người dân và du khách','img/news_vietjet_2.jpg','<p>(Vietjet, TP.HCM, ngày 29/10/2024) – Đáp ứng nhu cầu du lịch cao điểm cuối năm và bay Tết, du xuân năm mới, từ ngày 7/11/2024, Vietjet mở loạt đường bay kết nối các điểm đến du lịch hấp dẫn hàng đầu Đà Nẵng - Đà Lạt, Đà Nẵng - Phú Quốc và Cần Thơ - Đà Lạt, với vé khuyến mãi chỉ từ 0 đồng (*) mở bán từ 12h - 14h mỗi ngày tại website www.vietjetair.com và ứng dụng di động Vietjet Air.</p><p>&nbsp;</p><p><img src=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/dsasda-1730251842340.jpg\" alt=\"\" width=\"100%\"></p><p>&nbsp;</p><p>Theo đó, từ ngày 7/11/2024, đường bay Đà Nẵng - Đà Lạt sẽ khai thác với tần suất 3 chuyến khứ hồi/tuần vào các ngày thứ Ba, Năm, Bảy. Đường bay Đà Lạt - Cần Thơ cũng được khai thác trở lại từ ngày 7/11/2024 với tần suất 3 chuyến khứ hồi/tuần vào các ngày thứ Ba, Năm, Bảy.</p><p>&nbsp;</p><p>Từ ngày 08/11/2024, đường bay Đà Nẵng - Phú Quốc đi vào phục vụ khách hàng, tần suất 4 chuyến khứ hồi/tuần vào thứ Hai, Tư, Sáu, Chủ Nhật.</p><p>&nbsp;</p><p><img src=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/cafsa-1730251857817.jpg\" alt=\"\" width=\"100%\"></p><p>&nbsp;</p><p>Đà Nẵng được biết tới là thành phố đáng sống nhất Việt Nam với những bãi biển xinh đẹp, bán đảo Sơn Trà, Ngũ Hành Sơn, các khu nghỉ dưỡng sang trọng..., nơi dễ dàng để bắt đầu trải nghiệm con đường Di sản miền Trung với Hội An, Mỹ Sơn hay cố đô Huế… Trong khi đó, Đà Lạt là thành phố ngàn hoa, địa điểm du lịch hàng đầu Việt Nam như hồ Than Thở, núi Langbiang, thác Datanla. Còn Cần Thơ là vùng đất Tây Đô nổi tiếng bởi sự trù phú, sở hữu phong cảnh sông nước, miệt vườn đặc trưng và vùng nông nghiệp lớn. Đảo Ngọc Phú Quốc trong khi đó là thiên đường du lịch biển, điểm đến được yêu thích của rất nhiều du khách khắp trong, ngoài nước với Hòn Thơm, bãi Sao,…</p><p>&nbsp;</p><p>Với mạng bay rộng khắp của Vietjet, các đường bay thẳng kết nối các điểm đến nổi tiếng Việt Nam và thế giới không chỉ giúp người dân và du khách di chuyển dễ dàng mà còn mở ra cơ hội phát triển du lịch, giao thương hơn bao giờ hết giữa các địa điểm du lịch, các vùng kinh tế lớn.</p><p>&nbsp;</p><p><img src=\"https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/da-nang-1730251868042.jpg\" alt=\"\" width=\"100%\"></p><p>&nbsp;</p><p>Vé bay đã được mở bán cùng với chương trình ưu đãi hấp dẫn chỉ từ 0 đồng (*) vào 12h - 14h mỗi ngày trên website www.vietjetair.com và ứng dụng điện thoại Vietjet Air. Mùa lễ hội cuối năm này, bạn có thêm lựa chọn hành trình hấp dẫn với các điểm đến du lịch nổi tiếng khắp cả nước, “làm mới chính mình”, sẵn sàng khởi đầu một năm mới tốt lành, hứa hẹn nhiều khởi sắc may mắn nguyên năm.</p><p>&nbsp;</p><p>Đặt vé bay ngay, nhận thêm bảo hiểm du lịch Sky Care miễn phí, tích điểm chương trình khách hàng thân thiết Vietjet SkyJoy, trải nghiệm tàu bay hiện đại, thân thiện môi trường, được phục vụ bởi phi hành đoàn chuyên nghiệp, tận tâm với dịch vụ từ trái tim, thưởng thức các món ăn nóng sốt, tươi ngon của ẩm thực Việt Nam như Bánh mì, Phở Thìn, cà phê sữa đá cùng tinh hoa ẩm thực thế giới và nhiều chương trình văn hoá nghệ thuật đặc sắc trên độ cao 10.000 mét.</p><p>&nbsp;</p><p>(*) Chưa bao gồm thuế, phí</p>',1,6,4),(7,'FLYEZY Maintenance Notice 05/11 - 09/11','img/news_flyezy.png','<p>Dear Valued Customers,</p><p>We would like to inform you that our online flight booking website will be undergoing scheduled maintenance from <strong>November 5 to November 9</strong>. During this period, our website will be temporarily unavailable.</p><p>This maintenance is essential to improve the quality and performance of our services. We apologize for any inconvenience this may cause and appreciate your patience and understanding.</p><p>Please plan your bookings accordingly. Our team is working hard to resume services as quickly as possible.</p><p>Thank you for choosing us, and we look forward to serving you soon!</p><p>Best regards,</p><p>FLYEZY</p>',1,4,1);