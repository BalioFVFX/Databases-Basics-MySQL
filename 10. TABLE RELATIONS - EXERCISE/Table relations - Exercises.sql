CREATE DATABASE `one_to_one`;
USE `one_to_one`;

#-- 1.	One-To-One Relationship
CREATE TABLE `persons` (
    `person_id` INT(11) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `salary` DECIMAL(10 , 2 ) NOT NULL DEFAULT 0,
    `passport_id` INT(11) UNSIGNED NOT NULL UNIQUE
);

CREATE TABLE `passports` (
    `passport_id` INT(11) UNSIGNED UNIQUE PRIMARY KEY AUTO_INCREMENT ,
    `passport_number` VARCHAR(8) NOT NULL UNIQUE
)  AUTO_INCREMENT=101;

INSERT 
	INTO `persons` (`first_name`, `salary`, `passport_id`) 
	VALUES 
		('Roberto', 43300, 102), 
		('Tom', 56100, 103), 
		('Yana', 60200, 101);

INSERT 
	INTO `passports` (`passport_number`) 
    VALUES ('N34FG21B'), ('K65LO4R7'), ('ZE657QP2');

ALTER TABLE `persons` 
	ADD CONSTRAINT `pk_persons` 
		PRIMARY KEY (`person_id`),
    ADD CONSTRAINT `fk_persons_passports` 
		FOREIGN KEY(`passport_id`) 
        REFERENCES `passports`(`passport_id`);

#-- 2.	One-To-Many Relationship
CREATE DATABASE `one_to_many`;
USE `one_to_many`;

CREATE TABLE `manufacturers` (
    `manufacturer_id` INT(11) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `established_on` DATE NOT NULL
);

CREATE TABLE `models` (
    `model_id` INT(11) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `manufacturer_id` INT(11) UNSIGNED NOT NULL
)  AUTO_INCREMENT=101;

ALTER TABLE `manufacturers`
	ADD CONSTRAINT `pk_manufacturers`
    PRIMARY KEY (`manufacturer_id`);
    
ALTER TABLE `models`
	ADD CONSTRAINT `pk_models`
		PRIMARY KEY (`model_id`),
ADD CONSTRAINT `fk_models_manufacturers`
		FOREIGN KEY (`manufacturer_id`)
    REFERENCES `manufacturers`(`manufacturer_id`);

INSERT 
	INTO `manufacturers` (`name`, `established_on`) 
	VALUES 
		('BMW', '1916-03-01'), 
		('Tesla', '2003-01-01'), 
		('Lada', '1966-05-01');
        
INSERT 
	INTO `models` (`name`, `manufacturer_id`) 
	VALUES 
		('X1', 1), 
		('i6', 1), 
		('Model S', 2),
        ('Model X', 2),
        ('Model 3', 2),
        ('Nova', 3);

#-- 3.	Many-To-Many Relationship
CREATE DATABASE `many_to_many`;
USE `many_to_many`;

CREATE TABLE `students` (
    `student_id` INT(11) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE `exams` (
    `exam_id` INT(11) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
)  AUTO_INCREMENT=101;

CREATE TABLE `students_exams` (
    `student_id` INT(11) UNSIGNED NOT NULL,
    `exam_id` INT(11) UNSIGNED NOT NULL
);

ALTER TABLE `students`
	ADD CONSTRAINT `pk_students`
    PRIMARY KEY (`student_id`);
    
ALTER TABLE `exams`
	ADD CONSTRAINT `pk_exams`
    PRIMARY KEY (`exam_id`);
    
ALTER TABLE `students_exams`
	ADD CONSTRAINT `pk_students_exams`
		PRIMARY KEY (`student_id`, `exam_id`),
    ADD CONSTRAINT `fk_students_exams_students`
		FOREIGN KEY (`student_id`)
		REFERENCES `students` (`student_id`),
    ADD CONSTRAINT `fk_students_exams_exams`
		FOREIGN KEY (`exam_id`)
		REFERENCES `exams` (`exam_id`);

INSERT
	INTO `students` (`name`) 
		VALUES 
			('Mila'), 
			('Toni'), 
			('Ron');
            
INSERT
	INTO `exams` (`name`) 
		VALUES 
			('SpringMVC'), 
			('Neo4j'), 
			('Oracle 11g');
            
INSERT 
	INTO `students_exams`
    VALUES  
		(1, 101),
		(1, 102),
		(2, 101),
		(3, 103),
		(2, 102),
		(2, 103);

#-- 4.	Self-Referencing
CREATE DATABASE `self_referencing`;
USE `self_referencing`;

CREATE TABLE `teachers` (
    `teacher_id` INT UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `manager_id` INT UNSIGNED DEFAULT NULL
)  AUTO_INCREMENT=101;

INSERT 
	INTO `teachers`
		(`name`, `manager_id`)
    VALUES
		('John', NULL),
        ('Maya', 106),
        ('Silvia', 106),
        ('Ted', 105),
        ('Mark', 101),
        ('Greta', 101);

ALTER TABLE `teachers`
	ADD CONSTRAINT `pk_teachers`
		PRIMARY KEY (`teacher_id`),
	ADD CONSTRAINT `fk_manager_teacher`
		FOREIGN KEY (`manager_id`)
		REFERENCES `teachers` (`teacher_id`);
	
#-- 5.	Online Store Database
CREATE DATABASE `online_store_database`;
USE `online_store_database`;

CREATE TABLE `cities` (
    `city_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `customers` (
    `customer_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `birthday` DATE,
    `city_id` INT NOT NULL,
    CONSTRAINT `fk_customers_cities` 
		FOREIGN KEY (`city_id`)
        REFERENCES `cities` (`city_id`)
);

CREATE TABLE `item_types` (
    `item_type_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `items` (
    `item_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `item_type_id` INT NOT NULL,
    CONSTRAINT `fk_items_item_types` 
		FOREIGN KEY (`item_type_id`)
        REFERENCES `item_types` (`item_type_id`)
);

CREATE TABLE `orders` (
    `order_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    CONSTRAINT `fk_orders_customers` 
		FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`)
);

CREATE TABLE `order_items` (
    `order_id` INT NOT NULL,
    `item_id` INT NOT NULL,
		CONSTRAINT `pk_order_items` 
			PRIMARY KEY (`order_id` , `item_id`),
		CONSTRAINT `fk_order_items_orders`
			FOREIGN KEY (`order_id`)
            REFERENCES `orders`(`order_id`),
		CONSTRAINT `fk_order_items_items`
			FOREIGN KEY (`item_id`)
            REFERENCES `items`(`item_id`)
);

#-- 6.	University Database
CREATE DATABASE `univercity_database`;
USE `univercity_database`;

CREATE TABLE `majors`(
`major_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `students` (
    `student_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `student_number` VARCHAR(12) NOT NULL,
    `student_name` VARCHAR(50) NOT NULL,
    `major_id` INT NOT NULL,
    CONSTRAINT `fk_students_majors` 
		FOREIGN KEY (`major_id`)
        REFERENCES `majors` (`major_id`)
);

CREATE TABLE `payments` (
    `payment_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `payment_date` DATE,
    `payment_amount` DECIMAL(8 , 2 ),
    `student_id` INT NOT NULL,
    CONSTRAINT `fk_payments_students` 
		FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`)
);

CREATE TABLE `subjects` (
    `subject_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `subject_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `agenda` (
    `student_id` INT NOT NULL,
    `subject_id` INT NOT NULL,
		CONSTRAINT `pk_agenda` 
			PRIMARY KEY (`student_id` , `subject_id`),
		CONSTRAINT `fk_agenda_students` 
			FOREIGN KEY (`student_id`)
			REFERENCES `students` (`student_id`),
		CONSTRAINT `fk_agenda_subjects` 
			FOREIGN KEY (`subject_id`)
			REFERENCES `subjects` (`subject_id`)
);

#-- 9.	Peaks in Rila
USE `geography`;

SELECT 
    m.mountain_range,
    p.peak_name,
    p.elevation AS 'peak_elevation'
FROM
    `mountains` AS m
        JOIN
    `peaks` AS p ON m.id = p.mountain_id
WHERE
    m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;




