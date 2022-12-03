-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema streamingly
-- -----------------------------------------------------
-- A planform for songs' streaming.
DROP SCHEMA IF EXISTS `streamingly` ;

-- -----------------------------------------------------
-- Schema streamingly
--
-- A planform for songs' streaming.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `streamingly` ;
USE `streamingly` ;

-- -----------------------------------------------------
-- Table `streamingly`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`media` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`media` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `streamingly`.`songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`songs` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`songs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'song id',
  `title` VARCHAR(45) NOT NULL COMMENT 'title of the song',
  `filetype` VARCHAR(8) NOT NULL COMMENT 'type of the file (f.ex. mp4)',
  `song_media` INT UNSIGNED NOT NULL COMMENT 'pointer to the song',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `song_media_idx` (`song_media` ASC) VISIBLE,
  CONSTRAINT `media`
    FOREIGN KEY (`song_media`)
    REFERENCES `streamingly`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `streamingly`.`artists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`artists` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`artists` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'artist\'s id',
  `name` VARCHAR(45) NOT NULL COMMENT 'name of the artist',
  `image_media` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `image_media_idx` (`image_media` ASC) VISIBLE,
  CONSTRAINT `image_media`
    FOREIGN KEY (`image_media`)
    REFERENCES `streamingly`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `streamingly`.`rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`rating` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`rating` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `song_id` INT UNSIGNED NOT NULL,
  `count` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `rating_song_id_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `rating_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `streamingly`.`songs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB; 

USE `streamingly` ;

-- -----------------------------------------------------
-- Data for table `streamingly`.`media`
-- -----------------------------------------------------
START TRANSACTION;
USE `streamingly`;
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (16, '04_Andy_G._Cohen_Gazing.mp3');

COMMIT;

USE `streamingly`;

DELIMITER $$

USE `streamingly`$$
DROP TRIGGER IF EXISTS `streamingly`.`songs_AFTER_INSERT` $$
USE `streamingly`$$
CREATE DEFINER = CURRENT_USER TRIGGER `streamingly`.`songs_AFTER_INSERT` AFTER INSERT ON `songs` FOR EACH ROW
BEGIN
     INSERT INTO rating(song_id, count) VALUES(NEW.id, 0);
END$$


DELIMITER ;
