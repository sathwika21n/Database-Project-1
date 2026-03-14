-- =============================================
-- Flight Project sql script
-- MySQL
-- =============================================

-- AIRPORT
CREATE TABLE AIRPORT (
    Airport_code CHAR(3) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(10) NOT NULL,
    PRIMARY KEY (Airport_code)
);

--AIRPLANE_TYPE
CREATE TABLE AIRPLANE_TYPE (
    Type_name VARCHAR(50) NOT NULL,
    Company VARCHAR(100),
    Max_seats INT,
    PRIMARY KEY (Type_name)
);

-- AIRPLANE
CREATE TABLE AIRPLANE (
    Airplane_id VARCHAR(20) NOT NULL,
    Total_no_of_seats INT,
    Type_name VARCHAR(50),
    PRIMARY KEY (Airplane_id),
    FOREIGN KEY (Type_name) REFERENCES AIRPLANE_TYPE(Type_name)
);

-- FLIGHT
CREATE TABLE FLIGHT (
    Number INT NOT NULL,
    Airline VARCHAR(100),
    Weekdays CHAR(7),
    PRIMARY KEY (Number)
);

-- CAN_LAND (weak entity)
CREATE TABLE CAN_LAND (
    Airport_code CHAR(3) NOT NULL,
    Type_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (Airport_code, Type_name),
    FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Type_name) REFERENCES AIRPLANE_TYPE(Type_name)
);

-- FLIGHT_LEG
CREATE TABLE FLIGHT_LEG (
    Leg_no INT NOT NULL,
    Flight_number INT NOT NULL,
    Scheduled_dep_time TIME,
    Scheduled_arr_time TIME,
    Departure_airport CHAR(3),
    Arrival_airport CHAR(3),
    PRIMARY KEY (Leg_no, Flight_number),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Number),
    FOREIGN KEY (Departure_airport) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Arrival_airport) REFERENCES AIRPORT(Airport_code)
);

-- LEG_INSTANCE
CREATE TABLE LEG_INSTANCE (
    Leg_no INT NOT NULL,
    Flight_number INT NOT NULL,
    Date DATE NOT NULL,
    No_of_avail_seats INT,
    Airplane_id VARCHAR(20),
    PRIMARY KEY (Leg_no, Flight_number, Date),
    FOREIGN KEY (Leg_no, Flight_number) REFERENCES FLIGHT_LEG(Leg_no, Flight_number),
    FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id)
);

-- FARE
CREATE TABLE FARE (
    Code VARCHAR(20) NOT NULL,
    Flight_number INT NOT NULL,
    Amount DECIMAL(10,2),
    Restrictions VARCHAR(255),
    PRIMARY KEY (Code, Flight_number),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Number)
);

-- SEAT
CREATE TABLE SEAT (
    Seat_no VARCHAR(5) NOT NULL,
    Leg_no INT NOT NULL,
    Flight_number INT NOT NULL,
    Date DATE NOT NULL,
    PRIMARY KEY (Seat_no, Leg_no, Flight_number, Date),
    FOREIGN KEY (Leg_no, Flight_number, Date)
        REFERENCES LEG_INSTANCE(Leg_no, Flight_number, Date)
);

-- =============================================
-- CSV Imports
-- =============================================

LOAD DATA LOCAL INFILE 'AIRPORT.csv'
INTO TABLE AIRPORT
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'AIRPLANE_TYPE.csv'
INTO TABLE AIRPLANE_TYPE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'AIRPLANE.csv'
INTO TABLE AIRPLANE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'FLIGHT.csv'
INTO TABLE FLIGHT
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'CAN_LAND.csv'
INTO TABLE CAN_LAND
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'FLIGHT_LEG.csv'
INTO TABLE FLIGHT_LEG
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'LEG_INSTANCE.csv'
INTO TABLE LEG_INSTANCE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'FARE.csv'
INTO TABLE FARE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'SEAT.csv'
INTO TABLE SEAT
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
