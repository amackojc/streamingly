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
-- Table `streamingly`.`albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`albums` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`albums` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'album\'s id',
  `name` VARCHAR(45) NOT NULL COMMENT 'name of the album',
  `image_media` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `albums_image_media_idx` (`image_media` ASC) VISIBLE,
  CONSTRAINT `albums_image_media`
    FOREIGN KEY (`image_media`)
    REFERENCES `streamingly`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `streamingly`.`songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`songs` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`songs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'song id',
  `album_id` INT UNSIGNED NOT NULL COMMENT 'album id',
  `title` VARCHAR(45) NOT NULL COMMENT 'title of the song',
  `filetype` VARCHAR(8) NOT NULL COMMENT 'type of the file (f.ex. mp4)',
  `song_media` INT UNSIGNED NOT NULL COMMENT 'pointer to the song',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `song_media_idx` (`song_media` ASC) VISIBLE,
  CONSTRAINT `album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `streamingly`.`albums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
-- Table `streamingly`.`song_artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streamingly`.`song_artist` ;

CREATE TABLE IF NOT EXISTS `streamingly`.`song_artist` (
  `song_id` INT UNSIGNED NOT NULL,
  `artist_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `song_artist_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `streamingly`.`songs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sond_artist_artist_id`
    FOREIGN KEY (`artist_id`)
    REFERENCES `streamingly`.`artists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'A table that will let us map songs with artists ----> n:m';

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
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (1, 'till_paradiso.jpeg');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (2, '01_Till_Paradiso_Frisco_Bar_at_Midnight.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (3, '02_Till_Paradiso_Ginger_Underground.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (4, '03_Till_Paradiso_I_need_your_Love.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (5, '04_Till_Paradiso_Wont_Say_This_the_Last_Time.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (6, '05_Till_Paradiso_Night_Prelude.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (7, '06_Till_Paradiso_Full_of_Love.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (8, '07_Till_Paradiso_Covid-19.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (9, '08_Till_Paradiso_Mr_Mix_Pickels.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (10, 'stay_tonight.jpeg');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (11, 'prisma.jpeg');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (12, 'andy_cohen.jpeg');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (13, '01_Andy_G._Cohen_Hoist.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (14, '02_Andy_G._Cohen_Decapod.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (15, '03_Andy_G._Cohen_In_Awareness.mp3');
INSERT INTO `streamingly`.`media` (`id`, `path`) VALUES (16, '04_Andy_G._Cohen_Gazing.mp3');

COMMIT;

-- -----------------------------------------------------
-- Data for table `streamingly`.`albums`
-- -----------------------------------------------------
START TRANSACTION;
USE `streamingly`;
INSERT INTO `streamingly`.`albums` (`id`, `name`, `image_media`) VALUES (1, 'Stay Tonight', 10);
INSERT INTO `streamingly`.`albums` (`id`, `name`, `image_media`) VALUES (2, 'Prisma', 11);

COMMIT;

-- -----------------------------------------------------
-- Data for table `streamingly`.`songs`
-- -----------------------------------------------------
START TRANSACTION;
USE `streamingly`;
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Frisco Bar at Midnight', 'mp3', 2);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Ginger Underground', 'mp3', 3);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'I need your Love', 'mp3', 4);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Won\'t Say This the Last Time', 'mp3', 5);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Night Prelude', 'mp3', 6);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Full of Love', 'mp3', 7);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Covid-19', 'mp3', 8);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 1, 'Mr Mix Pickels', 'mp3', 9);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Hoist', 'mp3', 13);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Decapod', 'mp3', 14);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'In Awareness', 'mp3', 15);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Gazing', 'mp3', 16);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Minty Soak', 'mp3', 17);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Our Young Guts', 'mp3', 18);
INSERT INTO `streamingly`.`songs` (`id`, `album_id`, `title`, `filetype`, `song_media`) VALUES (NULL, 2, 'Epoxy Resin', 'mp3', 19);

COMMIT;

-- -----------------------------------------------------
-- Data for table `streamingly`.`artists`
-- -----------------------------------------------------
START TRANSACTION;
USE `streamingly`;
INSERT INTO `streamingly`.`artists` (`id`, `name`, `image_media`) VALUES (1, 'Till Paradiso', 1);
INSERT INTO `streamingly`.`artists` (`id`, `name`, `image_media`) VALUES (2, 'Andy G. Cohen', 12);
INSERT INTO `streamingly`.`artists` (`id`, `name`, `image_media`) VALUES (3, 'Derek Clegg', 20);

COMMIT;

-- -----------------------------------------------------
-- Data for table `streamingly`.`song_artist`
-- -----------------------------------------------------
START TRANSACTION;
USE `streamingly`;
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (1, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (2, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (3, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (4, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (5, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (6, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (7, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (8, 1);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (9, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (10, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (11, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (12, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (13, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (14, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (15, 2);
INSERT INTO `streamingly`.`song_artist` (`song_id`, `artist_id`) VALUES (16, 3);

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
