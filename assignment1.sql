DROP DATABASE IF EXISTS restaurantDB;
CREATE DATABASE restaurantDB;

CREATE TABLE orders (
    ID integer primary key, 
    price DECIMAL(10, 2),
    items varchar(100), 
    deliveryTime varchar(50),
    placementTime varchar(50),
    tip varchar(10)
);

CREATE TABLE employee (
    ID integer primary key,
    email varchar(100),
    firstName varchar(50),
    qualifications varchar(50),
    lastName varchar(50)
); 

CREATE TABLE Schedule(
    start varchar(10),
    end varchar(10),
    days varchar(10),
    employee_id integer NOT NULL,
    primary key(employee_id,days),
    FOREIGN KEY (employee_id) REFERENCES employee(ID) 
);

CREATE TABLE customer (
    email varchar(100) primary key, 
    phone char(10),
    firstName varchar(50),
    lastName varchar(50),
    orderID integer,
    employeeID integer not null,
    FOREIGN KEY(orderID) REFERENCES orders(ID),
    FOREIGN KEY(employeeID) REFERENCES employee(ID)
);

CREATE TABLE Restaurant (
    name varchar(100) primary key,
    url varchar(100),
    city varchar(100),
    province varchar(100),
    street varchar(100),
    streetNo integer,
    postalCode varchar(6),
    CustomerEmail varchar(100),
    employeeID integer,
    orderID integer,
    FOREIGN KEY(CustomerEmail) REFERENCES customer(email),
    FOREIGN KEY(employeeID) REFERENCES employee(ID),
    FOREIGN KEY(orderID) REFERENCES orders(ID)
);  

CREATE TABLE chef (
    name varchar(100),
    email varchar(100),
    firstName varchar(50),
    qualifications varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID),
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name)
);

CREATE TABLE server (
    name varchar(100),
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID),
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name)
);

CREATE TABLE delivery (
    name varchar(100),
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID),
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name)
);

CREATE TABLE management (
    name varchar(100),
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID),
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name)
);

CREATE TABLE Account(
    Credit decimal(10,2),
    date varchar(9),
    paymentMade varchar(10),
    CustomerEmail varchar(100) not null,
    primary key (CustomerEmail,date,paymentMade),
    FOREIGN KEY (CustomerEmail) REFERENCES customer(email)
);

CREATE TABLE food_menu(
    restaurantName varchar(100) not null,
    primary key (restaurantName),
    FOREIGN KEY (restaurantName) REFERENCES Restaurant(name)
);
CREATE TABLE item(
    itemName varchar(100),
    itemPrice decimal(10,2),
    restaurantName varchar(100) not null,
    primary key(restaurantName,itemName),
    FOREIGN KEY (restaurantName) REFERENCES food_menu(restaurantName) 
);

-- orders table
INSERT INTO orders (ID, price, items, deliveryTime, placementTime, tip)
VALUES (1, 22.50, 'Cheeseburger, Fries, Coke', '7:00 PM', '6:00 PM', '5.00'),
       (2, 45.00, 'Large Pizza', '8:00 PM', '7:00 PM', '7.50'),
       (3, 12.00, 'Chicken Caesar Salad', '12:00 PM', '11:30 AM', '2.50'),
       (4, 18.00, 'Fish and Chips', '7:30 PM', '6:45 PM', '4.00'),
       (5, 30.00, 'Sushi Platter', '6:30 PM', '6:00 PM', '5.00'),
       (6, 24.00, 'Pad Thai', '6:45 PM', '6:30 PM', '3.00');

-- employee table
INSERT INTO employee (ID, email, firstName, qualifications, lastName)
VALUES (1, 'john.doe@example.com', 'John', 'Cook', 'Doe'),
       (2, 'jane.doe@example.com', 'Jane', 'Server', 'Doe'),
       (3, 'jim.smith@example.com', 'Jim', 'Cook', 'Smith'),
       (4, 'sarah.jones@example.com','Sarah', 'Delivery', 'Jones'),
       (5, 'david.white@example.com','David', 'Cook', 'White'),
       (6, 'emily.green@example.com', 'Emily', 'Server', 'Green'),
       (7, 'samuel.brown@example.com', 'Samuel', 'Management', 'Brown');

-- Schedule table
INSERT INTO Schedule (start, end, days, employee_id)
VALUES ('8:00 AM', '12:00 PM', 'Monday', 1),
       ('12:00 PM', '4:00 PM', 'Monday', 2),
       ('4:00 PM', '8:00 PM', 'Monday', 3),
       ('8:00 AM', '12:00 PM', 'Tuesday', 1),
       ('12:00 PM', '4:00 PM', 'Tuesday', 2),
       ('4:00 PM', '8:00 PM', 'Tuesday', 3),
       ('8:00 AM', '12:00 PM', 'Wednesday', 1),
       ('12:00 PM', '4:00 PM', 'Wednesday', 2),
       ('4:00 PM', '8:00 PM', 'Wednesday', 3);


-- Customer table
INSERT INTO customer(email, phone, firstName, lastName, orderID, employeeID) VALUES
    ('johndoe@example.com', '1234567890', 'John', 'Doe', 1, 1),
    ('janedoe@example.com', '0987654321', 'Jane', 'Doe', 2, 2),
    ('bobsmith@example.com', '1112223333', 'Bob', 'Smith', 3, 3),
    ('robertgreen@example.com', '2223334444', 'Robert', 'Green', 6, 3);

-- Restaurant table
INSERT INTO Restaurant(name, url, city, province, street, streetNo, postalCode, CustomerEmail, employeeID, orderID) VALUES
    ('Pizza Place', 'pizzaplace.com', 'Toronto', 'Ontario', 'Yonge St', 123, 'M5T 1H2', 'johndoe@example.com', 1, 1),
    ('Sushi Spot', 'sushispot.com', 'Vancouver', 'British Columbia', 'Main St', 456, 'V5Y 1C7', 'janedoe@example.com', 2, 2),
    ('Burger Joint', 'burgerjoint.com', 'Montreal', 'Quebec', 'Saint-Catherine St', 789, 'H3B 1A6', 'bobsmith@example.com', 3, 3),
    ('Mexican Grill', 'mexicangrill.com', 'Calgary', 'Alberta', '17 Ave SW', 321, 'T2S 0B4', 'johndoe@example.com', 4, 4),
    ('Thai Restaurant', 'thaifood.com', 'Edmonton', 'Alberta', 'Jasper Ave', 654, 'T5J 1Y8', 'robertgreen@example.com', 5, 5),
    ('Chinese Cuisine', 'chinesefood.com', 'Winnipeg', 'Manitoba', 'Portage Ave', 987, 'R3G 0P8', 'johndoe@example.com', 6, 6),
    ('Italian Eatery', 'italianfood.com', 'Halifax', 'Nova Scotia', 'Quinpool Rd', 123, 'B3L 1H3', 'robertgreen@example.com', 7, 6);

-- Insert statements for the chef table
INSERT INTO chef (name, email, firstName, qualifications, lastName, ID, restaurantName) 
VALUES ('John Smith', 'john.smith@example.com', 'John', 'Culinary Arts', 'Smith', 1001, 'The French Bistro');

INSERT INTO chef (name, email, firstName, qualifications, lastName, ID, restaurantName) 
VALUES ('Mary Lee', 'mary.lee@example.com', 'Mary', 'Gourmet Cuisine', 'Lee', 1002, 'The Italian Restaurant');

INSERT INTO chef (name, email, firstName, qualifications, lastName, ID, restaurantName) 
VALUES ('Tom Brown', 'tom.brown@example.com', 'Tom', 'Baking and Pastry', 'Brown', 1003, 'The Steakhouse');


-- Insert statements for the server table
INSERT INTO server (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Maggie Johnson', 'maggie.johnson@example.com', 'Maggie', 'Johnson', 2001, 'The French Bistro');

INSERT INTO server (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Timothy Lee', 'timothy.lee@example.com', 'Timothy', 'Lee', 2002, 'The Italian Restaurant');

INSERT INTO server (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Julia Chen', 'julia.chen@example.com', 'Julia', 'Chen', 2003, 'The Steakhouse');


-- Insert statements for the delivery table
INSERT INTO delivery (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Chris Jackson', 'chris.jackson@example.com', 'Chris', 'Jackson', 3001, 'The French Bistro');

INSERT INTO delivery (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Lila Smith', 'lila.smith@example.com', 'Lila', 'Smith', 3002, 'The Italian Restaurant');

INSERT INTO delivery (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Juan Martinez', 'juan.martinez@example.com', 'Juan', 'Martinez', 3003, 'The Steakhouse');


-- Insert statements for the management table
INSERT INTO management (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('David Lee', 'david.lee@example.com', 'David', 'Lee', 4001, 'The French Bistro');

INSERT INTO management (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Sarah Johnson', 'sarah.johnson@example.com', 'Sarah', 'Johnson', 4002, 'The Italian Restaurant');

INSERT INTO management (name, email, firstName, lastName, ID, restaurantName) 
VALUES ('Benjamin Park', 'benjamin.park@example.com', 'Benjamin', 'Park', 4003, 'The Steakhouse');
