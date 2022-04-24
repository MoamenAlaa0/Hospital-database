-- Moamen Alaa Masnour Mohamed - 20191615891 

-- CREATE DATABASE Hospital;

-- USE Hospital;

CREATE TABLE person (
    ID INT NOT NULL IDENTITY,
    name VARCHAR(20) NOT NULL,
    day_of_birth DATE,
    address VARCHAR(50),
    salary DECIMAL (15, 2),
PRIMARY KEY (ID),
UNIQUE (ID)
);

CREATE TABLE nurse (
    ID INT NOT NULL IDENTITY,
    person_ID INT NOT NULL,
    ward_ID INT NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (person_ID) REFERENCES person (ID) ON DELETE CASCADE,
UNIQUE (ID)
);

CREATE TABLE ward (
    ID INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    nurse_ID INT,
PRIMARY KEY (ID),
UNIQUE (ID)
);

ALTER TABLE nurse
ADD FOREIGN KEY (ward_ID) REFERENCES ward(ID) ON DELETE CASCADE;

CREATE TABLE physician (
    ID INT NOT NULL IDENTITY,
    person_ID INT NOT NULL,
    speciality VARCHAR(10) NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (person_ID) REFERENCES person (ID),
UNIQUE (ID)
);

CREATE TABLE patient (
    ID INT NOT NULL IDENTITY,
    name VARCHAR(20) NOT NULL,
    address VARCHAR(50),
    day_of_birth DATE,
    ward_ID INT NOT NULL,
    physician_ID INT NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (physician_ID) REFERENCES physician(ID) ON DELETE CASCADE,
FOREIGN KEY (ward_ID) REFERENCES ward(ID) ON DELETE CASCADE,
UNIQUE (ID)
);

CREATE TABLE examination (
    physician_ID INT NOT NULL,
    patient_ID INT NOT NULL,
PRIMARY KEY (physician_ID, patient_ID),
FOREIGN KEY (patient_ID) REFERENCES patient(ID) ON DELETE CASCADE,
);

-- recommended_dosage is the amount of drug taken at any one time. This can be expressed as the weight of drug (e.g. 250 mg)
-- recommended_dosage: mg by one time

CREATE TABLE drug (
    code_num INT NOT NULL,
    recommended_dosage INT,
PRIMARY KEY (code_num),
UNIQUE (code_num)
);

CREATE TABLE brand (
    code_num INT NOT NULL,
    brand_name VARCHAR(30) NOT NULL,
PRIMARY KEY (code_num, brand_name),
FOREIGN KEY (code_num) REFERENCES drug(code_num) ON DELETE CASCADE
);

CREATE TABLE giving_drug (
    nurse_ID INT NOT NULL,
    patient_ID INT NOT NULL,
    code_num INT NOT NULL,
    at_date DATE,
    recommended_dosage INT,
PRIMARY KEY (nurse_ID, patient_ID, code_num),
FOREIGN KEY (nurse_ID) REFERENCES nurse(ID) ON DELETE CASCADE,
FOREIGN KEY (patient_ID) REFERENCES physician(ID) ON DELETE CASCADE,
FOREIGN KEY (code_num) REFERENCES drug(code_num) ON DELETE CASCADE,
);

INSERT INTO person 
VALUES ('Ahmed', '1988-5-16', 'Alex', 15000),
	   ('Heba', '1990-1-1', 'Alex', 9000);

INSERT INTO ward 
VALUES (5, 'clinic', 1);

INSERT INTO nurse 
VALUES (2, 5);

INSERT INTO physician 
VALUES (1, 'clinic');

INSERT INTO patient 
VALUES ('Mohamed', '16 street', '1995-9-20', 5, 1);

INSERT INTO examination 
VALUES (1, 1);

INSERT INTO drug 
VALUES (5510, 250);

INSERT INTO brand 
VALUES (5510, 'Ceevit');

INSERT INTO giving_drug
VALUES (1, 1, 5510, '2022-4-24', 250);
