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
    FOREIGN KEY (employee_id) REFERENCES employee(ID) ON DELETE CASCADE 
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
    postalCode varchar(7),
    CustomerEmail varchar(100),
    employeeID integer,
    orderID integer,
    FOREIGN KEY(CustomerEmail) REFERENCES customer(email),
    FOREIGN KEY(employeeID) REFERENCES employee(ID),
    FOREIGN KEY(orderID) REFERENCES orders(ID)
);  

CREATE TABLE chef (
    email varchar(100),
    firstName varchar(50),
    qualifications varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID) ON DELETE CASCADE,
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name) ON DELETE CASCADE
);

CREATE TABLE server (
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID) ON DELETE CASCADE,
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name) ON DELETE CASCADE
);

CREATE TABLE delivery (
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID),
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name) ON DELETE CASCADE
);

CREATE TABLE management (
    email varchar(100),
    firstName varchar(50),
    lastName varchar(50),
    ID integer not null,
    primary key(ID),
    FOREIGN KEY(ID) REFERENCES employee(ID) ON DELETE CASCADE,
    restaurantName varchar(100) not null,
    FOREIGN KEY(restaurantName) REFERENCES Restaurant(name) ON DELETE CASCADE
);

CREATE TABLE Account(
    Credit decimal(10,2),
    date date,
    paymentMade varchar(10),
    CustomerEmail varchar(100) not null,
    primary key (CustomerEmail,date,paymentMade),
    FOREIGN KEY (CustomerEmail) REFERENCES customer(email) ON DELETE CASCADE
);


CREATE TABLE food_menu(
    restaurantName varchar(100) not null,
    primary key (restaurantName),
    FOREIGN KEY (restaurantName) REFERENCES Restaurant(name) ON DELETE CASCADE
);
CREATE TABLE item(
    itemName varchar(100),
    itemPrice decimal(10,2),
    restaurantName varchar(100) not null,
    primary key(restaurantName,itemName),
    FOREIGN KEY (restaurantName) REFERENCES food_menu(restaurantName) ON DELETE CASCADE 
);
-- orders table
INSERT INTO orders (ID, price, items, deliveryTime, placementTime, tip)
VALUES (1, 22.50, 'Cheeseburger, Fries, Coke', '7:00 PM', '6:00 PM', '5.00'),
       (2, 45.00, 'Large Pizza', '8:00 PM', '7:00 PM', '7.50'),
       (3, 12.00, 'Chicken Caesar Salad', '12:00 PM', '11:30 AM', '2.50'),
       (4, 18.00, 'Fish and Chips', '7:30 PM', '6:45 PM', '4.00'),
       (5, 30.00, 'Sushi Platter', '6:30 PM', '6:00 PM', '5.00'),
       (6, 24.00, 'Pad Thai', '6:45 PM', '6:30 PM', '3.00');
-- Insert 6 chefs
INSERT INTO employee VALUES 
    (1, 'chef1@example.com', 'John', 'Culinary degree', 'Smith'),
    (2, 'chef2@example.com', 'Jane', 'Culinary degree', 'Doe'),
    (3, 'chef3@example.com', 'Bob', 'Culinary degree', 'Jones'),
    (4, 'chef4@example.com', 'Alice', 'Culinary degree', 'Lee'),
    (5, 'chef5@example.com', 'Mike', 'Culinary degree', 'Brown'),
    (6, 'chef6@example.com', 'Sarah', 'Culinary degree', 'Taylor');
-- Insert 6 managers
INSERT INTO employee VALUES 
    (7, 'manager1@example.com', 'Mark', 'MBA', 'Johnson'),
    (8, 'manager2@example.com', 'Emily', 'MBA', 'Wilson'),
    (9, 'manager3@example.com', 'Tom', 'MBA', 'Davis'),
    (10, 'manager4@example.com', 'Karen', 'MBA', 'Martin'),
    (11, 'manager5@example.com', 'Jack', 'MBA', 'Nguyen'),
    (12, 'manager6@example.com', 'Grace', 'MBA', 'Chen');
-- Insert 6 servers
INSERT INTO employee (ID, email, firstName, qualifications, lastName) VALUES
(13, 'server1@example.com', 'John', 'waiter', 'Doe'),
(14, 'server2@example.com', 'Jane', 'waitress', 'Smith'),
(15, 'server3@example.com', 'Bob', 'waiter', 'Johnson'),
(16, 'server4@example.com', 'Alice', 'waitress', 'Lee'),
(17, 'server5@example.com', 'David', 'waiter', 'Kim'),
(18, 'server6@example.com', 'Sarah', 'waitress', 'Chen');
-- Insert 6 delivery employees
INSERT INTO employee (ID, email, firstName, qualifications, lastName) VALUES
(19, 'delivery1@example.com', 'Chris', 'driver', 'Brown'),
(20, 'delivery2@example.com', 'Olivia', 'driver', 'Davis'),
(21, 'delivery3@example.com', 'Alex', 'driver', 'Garcia'),
(22, 'delivery4@example.com', 'Emily', 'driver', 'Jones'),
(23, 'delivery5@example.com', 'Jacob', 'driver', 'Miller'),
(24, 'delivery6@example.com', 'Mia', 'driver', 'Wilson');
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
    ('robertgreen@example.com', '2223334444', 'Robert', 'Green', 6, 3),
    ('sarahlee@example.com', '3334445555', 'Sarah', 'Lee', 4, 1),
    ('peterbrown@example.com', '4445556666', 'Peter', 'Brown', 5, 2),
    ('amynguyen@example.com', '5556667777', 'Amy', 'Nguyen', 6, 1),
    ('davidkang@example.com', '6667778888', 'David', 'Kang', 6, 2);

-- Restaurant table
INSERT INTO Restaurant(name, url, city, province, street, streetNo, postalCode, CustomerEmail, employeeID, orderID) VALUES
    ('Pizza Palace', 'pizzaplace.com', 'Toronto', 'Ontario', 'Yonge St', 123, 'M5T 1H2', 'johndoe@example.com', 1, 1),
    ('Sushi Spot', 'sushispot.com', 'Vancouver', 'British Columbia', 'Main St', 456, 'V5Y 1C7', 'janedoe@example.com', 2, 2),
    ('Burger Joint', 'burgerjoint.com', 'Montreal', 'Quebec', 'Saint-Catherine St', 789, 'H3B 1A6', 'bobsmith@example.com', 3, 3),
    ('Mexican Grill', 'mexicangrill.com', 'Calgary', 'Alberta', '17 Ave SW', 321, 'T2S 0B4', 'johndoe@example.com', 4, 4),
    ('Thai Restaurant', 'thaifood.com', 'Edmonton', 'Alberta', 'Jasper Ave', 654, 'T5J 1Y8', 'robertgreen@example.com', 5, 5),
    ('Chinese Cuisine', 'chinesefood.com', 'Winnipeg', 'Manitoba', 'Portage Ave', 987, 'R3G 0P8', 'johndoe@example.com', 6, 6),
    ('Italian Eatery', 'italianfood.com', 'Halifax', 'Nova Scotia', 'Quinpool Rd', 123, 'B3L 1H3', 'robertgreen@example.com', 7, 6);

INSERT INTO delivery ( email, firstName, lastName, ID, restaurantName) VALUES
('delivery1@example.com', 'Chris', 'Brown', 19, 'Pizza Palace'),
('delivery2@example.com', 'Olivia', 'Davis', 20, 'Pizza Palace'),
( 'delivery3@example.com', 'Alex', 'Garcia', 21, 'Pizza Palace'),
('delivery4@example.com', 'Emily', 'Jones', 22, 'Pizza Palace'),
( 'delivery5@example.com', 'Jacob', 'Miller', 23, 'Pizza Palace'),
( 'delivery6@example.com', 'Mia', 'Wilson', 24, 'Pizza Palace');

INSERT INTO server ( email, firstName, lastName, ID, restaurantName) VALUES
( 'server1@example.com', 'John', 'Doe', 13, 'Pizza Palace'),
( 'server2@example.com', 'Jane', 'Smith', 14, 'Pizza Palace'),
('server3@example.com', 'Bob', 'Johnson', 15, 'Pizza Palace'),
( 'server4@example.com', 'Alice', 'Lee', 16, 'Pizza Palace'),
( 'server5@example.com', 'David', 'Kim', 17, 'Pizza Palace'),
( 'server6@example.com', 'Sarah', 'Chen', 18, 'Pizza Palace');

INSERT INTO chef VALUES
    ( 'chef1@example.com', 'John', 'Culinary degree', 'Smith', 1, 'Sushi Spot'),
    ( 'chef2@example.com', 'Jane', 'Culinary degree', 'Doe', 2, 'Sushi Spot'),
    ( 'chef3@example.com', 'Bob', 'Culinary degree', 'Jones', 3, 'Sushi Spot'),
    ( 'chef4@example.com', 'Alice', 'Culinary degree', 'Lee', 4, 'Burger Joint'),
    ( 'chef5@example.com', 'Mike', 'Culinary degree', 'Brown', 5, 'Burger Joint'),
    ('chef6@example.com', 'Sarah', 'Culinary degree', 'Taylor', 6, 'Burger Joint');
    
INSERT INTO management VALUES
    ('manager1@example.com', 'Mark', 'Johnson', 7, 'Mexican Grill'),
    ('manager2@example.com', 'Emily', 'Wilson', 8, 'Mexican Grill'),
    ('manager3@example.com', 'Tom', 'Davis', 9, 'Thai Restaurant'),
    ( 'manager4@example.com', 'Karen', 'Martin', 10, 'Thai Restaurant'),
    ('manager5@example.com', 'Jack', 'Nguyen', 11, 'Thai Restaurant'),
    ( 'manager6@example.com', 'Grace', 'Chen', 12, 'Thai Restaurant');

INSERT INTO food_menu(restaurantName) VALUES ('Pizza Palace');
INSERT INTO food_menu(restaurantName) VALUES ('Sushi Spot');
INSERT INTO food_menu(restaurantName) VALUES ('Burger Joint');
INSERT INTO food_menu(restaurantName) VALUES ('Mexican Grill');
INSERT INTO food_menu(restaurantName) VALUES ('Thai Restaurant');
INSERT INTO food_menu(restaurantName) VALUES ('Chinese Cuisine');

INSERT INTO item(itemName, itemPrice, restaurantName) VALUES
    ('Pepperoni Pizza', 14.99, 'Pizza Palace'),
    ('Miso Soup', 5.99, 'Sushi Spot'),
    ('Classic Cheeseburger', 10.99, 'Burger Joint'),
    ('Chicken Quesadilla', 12.99, 'Mexican Grill'),
    ('Pad Thai', 13.99, 'Thai Restaurant'),
    ('Sweet and Sour Pork', 11.99, 'Chinese Cuisine');

INSERT INTO  Account(Credit,date,paymentMade,CustomerEmail)
VALUES (123.32,'2022-01-23',100,'johndoe@example.com'),
        (113.32,'2022-01-23',100,'janedoe@example.com'),
        (124.32,'2022-01-23',100,'bobsmith@example.com'),
        (23.32,'2022-01-23',100,'robertgreen@example.com'),
        (3.32,'2022-01-23',100,'sarahlee@example.com'),
        (13.2,'2022-01-23',100,'peterbrown@example.com');