-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema movies
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `movies` ;

-- -----------------------------------------------------
-- Schema movies
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movies` DEFAULT CHARACTER SET utf8 ;
USE `movies` ;

-- -----------------------------------------------------
-- Table `movies`.`rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`rating` ;

CREATE TABLE IF NOT EXISTS `movies`.`rating` (
  `rating_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating` ENUM('G', 'PG', 'PG-13') NOT NULL,
  PRIMARY KEY (`rating_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`studio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`studio` ;

CREATE TABLE IF NOT EXISTS `movies`.`studio` (
  `studio_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `studio_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`studio_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`year_released`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`year_released` ;

CREATE TABLE IF NOT EXISTS `movies`.`year_released` (
  `year_released_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`year_released_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`movie` ;

CREATE TABLE IF NOT EXISTS `movies`.`movie` (
  `movie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `rating_id` INT UNSIGNED NOT NULL,
  `studio_id` INT UNSIGNED NOT NULL,
  `year_released_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_id`),
  CONSTRAINT `fk_movie_rating`
    FOREIGN KEY (`rating_id`)
    REFERENCES `movies`.`rating` (`rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_studio1`
    FOREIGN KEY (`studio_id`)
    REFERENCES `movies`.`studio` (`studio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_year_released1`
    FOREIGN KEY (`year_released_id`)
    REFERENCES `movies`.`year_released` (`year_released_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_rating_idx` ON `movies`.`movie` (`rating_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_studio1_idx` ON `movies`.`movie` (`studio_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_year_released1_idx` ON `movies`.`movie` (`year_released_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movies`.`actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`actor` ;

CREATE TABLE IF NOT EXISTS `movies`.`actor` (
  `actor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `actor_first_name` VARCHAR(45) NOT NULL,
  `actor_last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`feature` ;

CREATE TABLE IF NOT EXISTS `movies`.`feature` (
  `feature_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`feature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`genre` ;

CREATE TABLE IF NOT EXISTS `movies`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`media` ;

CREATE TABLE IF NOT EXISTS `movies`.`media` (
  `media_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`media_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`price` ;

CREATE TABLE IF NOT EXISTS `movies`.`price` (
  `price_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `price_value` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`price_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies`.`movie_has_actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`movie_has_actor` ;

CREATE TABLE IF NOT EXISTS `movies`.`movie_has_actor` (
  `movie_id` INT UNSIGNED NOT NULL,
  `actor_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_id`, `actor_id`),
  CONSTRAINT `fk_movie_has_actor_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movies`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_actor_actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `movies`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_has_actor_actor1_idx` ON `movies`.`movie_has_actor` (`actor_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_has_actor_movie1_idx` ON `movies`.`movie_has_actor` (`movie_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movies`.`movie_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`movie_has_genre` ;

CREATE TABLE IF NOT EXISTS `movies`.`movie_has_genre` (
  `movie_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_id`, `genre_id`),
  CONSTRAINT `fk_movie_has_genre_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movies`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `movies`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_has_genre_genre1_idx` ON `movies`.`movie_has_genre` (`genre_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_has_genre_movie1_idx` ON `movies`.`movie_has_genre` (`movie_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movies`.`movie_has_feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`movie_has_feature` ;

CREATE TABLE IF NOT EXISTS `movies`.`movie_has_feature` (
  `movie_id` INT UNSIGNED NOT NULL,
  `feature_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_id`, `feature_id`),
  CONSTRAINT `fk_movie_has_feature_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movies`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_feature_feature1`
    FOREIGN KEY (`feature_id`)
    REFERENCES `movies`.`feature` (`feature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_has_feature_feature1_idx` ON `movies`.`movie_has_feature` (`feature_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_has_feature_movie1_idx` ON `movies`.`movie_has_feature` (`movie_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movies`.`movie_has_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movies`.`movie_has_media` ;

CREATE TABLE IF NOT EXISTS `movies`.`movie_has_media` (
  `movie_id` INT UNSIGNED NOT NULL,
  `media_id` INT UNSIGNED NOT NULL,
  `price_id` INT UNSIGNED NULL,
  PRIMARY KEY (`movie_id`, `media_id`),
  CONSTRAINT `fk_movie_has_media_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movies`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_media_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `movies`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_media_price1`
    FOREIGN KEY (`price_id`)
    REFERENCES `movies`.`price` (`price_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_has_media_media1_idx` ON `movies`.`movie_has_media` (`media_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_has_media_movie1_idx` ON `movies`.`movie_has_media` (`movie_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_has_media_price1_idx` ON `movies`.`movie_has_media` (`price_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE movies;

INSERT INTO rating
(rating)
VALUES
('G'),
('PG'),
('PG-13');

INSERT INTO year_released
(year)
VALUES
(1995),
(1999),
(1954),
(1977),
(2021),
(2022);

INSERT INTO studio
(studio_name)
VALUES
('Pixar'),
('MGM'),
('20th Century Fox'),
('Apple TV+'),
('A24'),
('Paramount'),
('Universal'),
('Disney');

INSERT INTO actor
(actor_first_name, actor_last_name)
VALUES
('Tom','Hanks'),
('Tim','Allen'),
('Annie','Potts'),
('John','Ratzenberger'),
('Gene','Kelly'),
('Cyd','Charisse'),
('Van','Johnson'),
('Harrison','Ford'),
('Carrie','Fisher'),
('Mark','Hamill'),
('Emilia','Jones'),
('Marlee','Matlin'),
('Troy','Kotsur'),
('Steven','Yeun'),
('Han','Ye-ri'),
('Youn','Yuh-jung'),
('Will','Patton'),
('Daniel','Craig'),
('Ada','de Armas'),
('Rami','Malek'),
('Ben','Schwartz'),
('Idris','Elba'),
('Colleen',"O'Shaughnessy"),
('Scarlet','Johansson'),
('Matthew','McConaughey'),
('Reese','Witherspoon'),
('Tori','Kelly'),
('Taron','Egerton'),
('Nick','Kroll'),
('Stephanie','Beatriz'),
('Diane','Guerrero'),
('Wilmer','Valderrama'),
('Angie','Cepeda'),
('Rhenzy','Feliz'),
('Carolina','Gaitán');

INSERT INTO feature
(feature_type)
VALUES
('Bloopers'),
('Actor Interviews'),
('Cut Scenes'),
('Trailers'),
('Sing-a-long'),
('Drawing the Characters'),
('Music Video'),
('Bonus Feature'),
('Journey to Columbia'),
('A Journey through Music');

INSERT INTO genre
(genre)
VALUES
('Family'),
('Animated'),
('Musical'),
('Romance'),
('Sci-Fi'),
('Comedy'),
('Drama'),
('Action'),
('Adventure'),
('Thriller'),
('Animation'),
('Fantasy');

INSERT INTO media
(media_type)
VALUES
('DVD'),
('Blu-Ray'),
('Streaming'),
('HD'),
('Digital');

INSERT INTO price
(price_value)
VALUES
(19.95),
(24.95),
(35.00),
(21.95),
(24.96),
(19.96),
(23.99);

INSERT INTO movie
(title, rating_id, year_released_id, studio_id)
VALUES
('Toy Story',1,1,1),
('Toy Story 2',1,2,1),
('Brigadoone',1,3,2),
('The Empire Strikes Back',2,4,3),
('Coda',3,5,4),
('Minari',3,5,5),
('No Time to Die',3,5,2),
('Sonic the Hedgehog 2',2,6,6),
('Sing 2',2,5,7),
('Encanto',2,5,8);

INSERT INTO movie_has_actor
(actor_id, movie_id)
VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(1,2),
(2,2),
(3,2),
(4,2),
(5,3),
(6,3),
(7,3),
(8,4),
(9,4),
(10,4),
(11,5),
(12,5),
(13,5),
(14,6),
(15,6),
(16,6),
(17,6),
(18,7),
(19,7),
(20,7),
(21,8),
(22,8),
(23,8),
(24,9),
(25,9),
(26,9),
(27,9),
(28,9),
(29,9),
(30,10),
(31,10),
(32,10),
(33,10),
(34,10),
(35,10);

INSERT INTO movie_has_feature
(movie_id, feature_id)
VALUES
(1,1),
(2,2),
(4,3),
(4,1),
(5,4),
(6,4),
(7,4),
(7,3),
(8,3),
(8,4),
(9,5),
(9,6),
(9,7),
(10,8),
(10,3),
(10,9),
(10,10);

INSERT INTO movie_has_media
(movie_id, media_id, price_id)
VALUES
(1,1,1),
(2,1,2),
(3,1,1),
(4,2,3),
(5,3,NULL),
(6,3,NULL),
(7,4,2),
(7,1,4),
(7,5,2),
(8,1,1),
(8,4,2),
(9,2,5),
(9,4,5),
(10,2,6),
(10,4,7),
(10,5,7);
