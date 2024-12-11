-- Creation de Database 

CREATE DATABASE FITTRACK;

use FITTRACK;

-- Creation des Tablaux 

CREATE TABLE membres (
    membrer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM("MALE" , "FEMALE"),
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE rooms(
    room_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type ENUM("Cardio","Weights","Studio") NOT  NULL,
    capacity INT 
);

CREATE TABLE membreships (
    membrership_id INT PRIMARY KEY AUTO_INCREMENT,
    membrer_id INT,
    room_id INT,
    start_date DATE NOT NULL,
    FOREIGN KEY (membrer_id) REFERENCES membres(membrer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);


CREATE TABLE departments(
    departmen_id INT PRIMARY KEY NOT NULL,
    department_name VARCHAR(50),
    location VARCHAR(100)
);


CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    departmen_id INT,
    FOREIGN KEY (departmen_id) REFERENCES departments(departmen_id)
);


CREATE TABLE appointments(
    appointment_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    membrer_id INT, 
    trainer_id INT,
    FOREIGN KEY (membrer_id) REFERENCES membres(membrer_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);


CREATE TABLE workour_plans(
    plan_id INT PRIMARY KEY NOT NULL, 
    instructions VARCHAR(255),
    membrer_id INT,
    trainer_id INT,
    FOREIGN KEY (membrer_id) REFERENCES membres(membrer_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);


INSERT INTO membres (first_name, last_name, gender, date_of_birth, phone_number, email) VALUES
('John', 'Doe', 'MALE', '1990-05-14', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', 'FEMALE', '1985-08-22', '0987654321', 'jane.smith@example.com'),
('Paul', 'Johnson', 'MALE', '1992-03-12', '1122334455', 'paul.johnson@example.com'),
('Emily', 'Brown', 'FEMALE', '1997-11-04', '2233445566', 'emily.brown@example.com'),
('Alice', 'Davis', 'FEMALE', '1999-07-19', '3344556677', 'alice.davis@example.com');


INSERT INTO rooms (room_number, room_type, capacity) VALUES
('101', 'Cardio', 20),
('102', 'Weights', 15),
('103', 'Studio', 25),
('104', 'Cardio', 30),
('105', 'Weights', 10);


INSERT INTO membreships (membrer_id, room_id, start_date) VALUES
(1, 1, '2024-01-01'),
(2, 2, '2024-01-05'),
(3, 3, '2024-01-10'),
(4, 1, '2024-01-15'),
(5, 2, '2024-01-20');



INSERT INTO departments (departmen_id, department_name, location) VALUES
(1, 'Fitness Training', 'First Floor'),
(2, 'Nutrition', 'Second Floor'),
(3, 'Customer Service', 'Ground Floor'),
(4, 'Administration', 'Third Floor'),
(5, 'Maintenance', 'Basement');



INSERT INTO trainers (first_name, last_name, specialization, departmen_id) VALUES
('Mark', 'Taylor', 'Cardio Training', 1),
('Sara', 'Wilson', 'Weightlifting', 1),
('Michael', 'Lee', 'Yoga', 2),
('Laura', 'White', 'Aerobics', 1),
('David', 'Martinez', 'CrossFit', 1);


INSERT INTO appointments (appointment_id, appointment_date, appointment_time, membrer_id, trainer_id) VALUES
(1, '2024-02-01', '10:00:00', 1, 1),
(2, '2024-02-02', '11:00:00', 2, 2),
(3, '2024-02-03', '09:30:00', 3, 3),
(4, '2024-02-04', '14:00:00', 4, 4),
(5, '2024-02-05', '16:00:00', 5, 5);


INSERT INTO workour_plans (plan_id, instructions, membrer_id, trainer_id) VALUES
(1, '30 minutes cardio + 20 minutes strength training', 1, 1),
(2, '40 minutes weightlifting', 2, 2),
(3, '1 hour yoga session', 3, 3),
(4, '30 minutes aerobics + 10 minutes stretching', 4, 4),
(5, '45 minutes CrossFit training', 5, 5);


-- Exercices ------------------------------------------------------------------


-- 1 Opérations CRUD : Insérer un nouveau membre : 
INSERT INTO membres(first_name, last_name, gender, date_of_birth, phone_number) VALUES ("Alex" , "Johnson" , "MALE","1990-07-15" , "1234567890");

-- 2 Instruction SELECT : Récupérer tous les départements Récupérez tous les départements avec leurs emplacements.
SELECT * FROM departments;

-- 3 Clause ORDER BY : Trier les membres par date de naissance Listez tous les membres, triés par date de naissance dans l'ordre croissant.

SELECT * FROM membres ORDER BY date_of_birth;

-- 4 Filtrer les membres uniques par sexe (DISTINCT) Récupérez tous les sexes des membres enregistrés, sans doublons.

SELECT DISTINCT gender FROM membres;

-- 5 Clause LIMIT : Obtenir les 3 premiers entraîneurs Récupérez les trois premiers entraîneurs dans la table des entraîneurs.

SELECT * FROM trainers LIMIT 3;

-- 6 Clause WHERE : Membres nés après 2000 Récupérez les informations des membres nés après l'année 2000.

SELECT * FROM membres WHERE YEAR(date_of_birth) > 2000;

-- 7 Opérateurs Logiques : Entraîneurs dans des départements spécifiques Récupérez les entraîneurs des départements "Musculation" et "Cardio".

SELECT * FROM trainers WHERE departmen_id IN (SELECT departmen_id FROM departments WHERE department_name IN ("Musculation" , "Cardio"));

-- 8 Opérateurs Spéciaux : Vérifier des plages de dates Listez les abonnements entre le 1er décembre et le 7 décembre 2024.

SELECT * FROM membreships WHERE start_date BETWEEN "2024-01-01" AND "2024-01-07";

-- 9 Expressions Conditionnelles : Nommer les catégories d'âge des membres Ajoutez une colonne catégorisant les membres en "Junior", "Adulte", ou "Senior" selon leur âge.

ALTER TABLE membres
ADD COLUMN category VARCHAR(10);

UPDATE membres
SET category = CASE
    WHEN YEAR(CURDATE()) - YEAR(date_of_birth) < 18 THEN 'Junior'
    WHEN YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 18 AND 59 THEN 'Adult'
    ELSE 'Senior'
END;

-- 10 Fonctions d'Agrégation : Nombre total de rendez-vous Comptez le nombre total de rendez-vous d'entraînement enregistrés.

SELECT COUNT(*) FROM appointments;

-- 11 COUNT avec GROUP BY : Nombre d'entraîneurs par département Comptez le nombre d'entraîneurs dans chaque département.

SELECT  D.department_name , T.departmen_id , COUNT(T.trainer_id) FROM departments D, trainers T WHERE D.departmen_id = T.departmen_id GROUP BY T.departmen_id; 

-- 12 AVG : Âge moyen des membres Calculez l'âge moyen des membres.

SELECT AVG( TIMESTAMPDIFF(YEAR , date_of_birth , CURRENT_DATE) ) FROM membres;

-- 13 MAX : Dernier rendez-vous Trouvez la date et l'heure du dernier rendez-vous enregistré.

SELECT * FROM appointments ORDER BY appointment_id DESC LIMIT 1;

-- 14 SUM : Total des abonnements par salle Calculez le total des abonnements pour chaque salle d'entraînement.

SELECT room_id , SUM(membrership_id) FROM membreships GROUP BY room_id;

-- 15 Contraintes : Vérifier les membres sans e-mail Récupérez tous les membres dont le champ email est vide.

SELECT * FROM membres WHERE email is NULL;

-- 16 Jointure : Liste des rendez-vous avec noms des entraîneurs et membre. Récupérez les rendez-vous avec les noms des entraîneurs et des membres.

SELECT A.appointment_id as Render_Vous , T.first_name as Nom_Entraineur , M.first_name as Nom_mombre  
FROM appointments A join  membres M on A.membrer_id = M.membrer_id join trainers T on A.trainer_id = T.trainer_id;  

-- 17 DELETE : Supprimer les rendez-vous avant 2024 Supprimez tous les rendez-vous programmés avant 2024.

DELETE FROM appointments WHERE  YEAR(appointment_date) < 2024;

-- 18 UPDATE : Modifier un département Changez le nom du département "Musculation" en "Force et Conditionnement".

UPDATE departments SET department_name = "Force et Conditionnement" WHERE department_name = "Musculation";

-- 19 Clause HAVING : Membres par sexe avec au moins 2 entrées Listez les genres ayant au moins deux membres.

SELECT gender , COUNT(*) as gr FROM membres GROUP BY gender HAVING gr > 1;

-- 20 Créer une vue : Abonnements actifs Créez une vue listant tous les abonnements en cours.

CREATE VIEW Abonnements_en_cours as SELECT * FROM membreships;
SELECT * FROM Abonnements_en_cours ;

-- Bonus 1 : Récupérez les noms des membres et les noms de leurs entraîneurs personnels à partir des tables membres, abonnements et entraîneurs.

SELECT M.first_name as Member_name , T.first_name as Entraineur
FROM membres M 
join appointments A on M.membrer_id = A.membrer_id 
JOIN trainers T on A.trainer_id = T.trainer_id; 

-- Bonus 2 : Récupérez la liste des rendez-vous avec les départements associés.

SELECT A.appointment_id , D.department_name , A.appointment_date , A.appointment_time
FROM appointments A 
join trainers T
on A.trainer_id = T.trainer_id
join departments D on T.departmen_id = D.departmen_id;

-- Bonus 3 : Listez les suppléments recommandés par chaque entraîneur.

SELECT W.plan_id , W.instructions , T.first_name as entraineur 
FROM trainers T 
join workour_plans W on W.trainer_id = T.trainer_id;

-- Bonus 4 : Récupérez les informations des abonnements et des salles où les membres sont assignés.

SELECT ME.first_name , R.room_number , R.room_type , M.membrership_id , M.start_date 
FROM membreships M 
JOIN membres ME on ME.membrer_id = M.membrer_id    
JOIN rooms R on M.room_id = R.room_id 
 










