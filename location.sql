CREATE TABLE `Country` (  
      `id` int(6) NOT NULL AUTO_INCREMENT,  
	  `country_name` varchar(200) NOT NULL,  
      PRIMARY KEY (`id`)  
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;  
	
CREATE TABLE `city` (  
      `id` int(6) NOT NULL AUTO_INCREMENT,  
	  `city_name` varchar(200) NOT NULL,  
  	  `country_id` int(6) NOT NULL,	  
	  FOREIGN KEY (`country_id`) REFERENCES Country(id), 
      PRIMARY KEY (`id`)  
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;  
	
INSERT INTO `test`.`country` (`country_name`) VALUES ('Belarus');
INSERT INTO `test`.`country` (`country_name`) VALUES ('Russia');
INSERT INTO `test`.`country` (`country_name`) VALUES ('Ukraine');

INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('Minsk', '5');
INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('Brest', '5');
INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('Moskow', '6');
INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('S-Peterburg', '6');
INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('Kiev', '7');
INSERT INTO `test`.`city` (`city_name`, `country_id`) VALUES ('Harkov', '7');

