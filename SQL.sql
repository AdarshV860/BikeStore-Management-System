-- Create the database
CREATE DATABASE BikeStoreDB;
USE BikeStoreDB;

-- Create the Brands table
CREATE TABLE Brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Categories table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Locations table
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Customer_Locations bridge table
CREATE TABLE Customer_Locations (
    customer_location_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    location_id INT NOT NULL,
    address_type ENUM('Home', 'Work', 'Other') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) ON DELETE CASCADE
);

-- Create the Stores table
CREATE TABLE Stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Store_Locations bridge table
CREATE TABLE Store_Locations (
    store_location_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    location_id INT NOT NULL,
    store_type ENUM('Retail', 'Warehouse') NOT NULL,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) ON DELETE CASCADE
);

-- Create the Staff table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    active BOOLEAN DEFAULT TRUE,
    store_id INT NOT NULL,
    manager_id INT NULL,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- Create the Products table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL CHECK (list_price >= 0),
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Create the Stocks table (bridge table for Stores and Products)
CREATE TABLE Stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Create the Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

-- Create the Order_Items table (bridge table for Orders and Products)
CREATE TABLE Order_Items (
    order_id INT NOT NULL,
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    list_price DECIMAL(10,2) NOT NULL CHECK (list_price >= 0),
    discount DECIMAL(5,2) DEFAULT 0 CHECK (discount >= 0 AND discount <= 100),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


INSERT INTO Brands (brand_id, brand_name) VALUES (8, 'Surly');
INSERT INTO Brands (brand_id, brand_name) VALUES (2, 'Haro');
INSERT INTO Brands (brand_id, brand_name) VALUES (6, 'Strider');
INSERT INTO Brands (brand_id, brand_name) VALUES (1, 'Electra');
INSERT INTO Brands (brand_id, brand_name) VALUES (9, 'Trek');

INSERT INTO Categories (category_id, category_name) VALUES (1, 'Children Bicycles');
INSERT INTO Categories (category_id, category_name) VALUES (2, 'Comfort Bicycles');
INSERT INTO Categories (category_id, category_name) VALUES (6, 'Mountain Bikes');
INSERT INTO Categories (category_id, category_name) VALUES (3, 'Cruisers Bicycles');
INSERT INTO Categories (category_id, category_name) VALUES (5, 'Electric Bikes');

INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (414, 'Romaine', 'Haley', '(312) 456-7890', 'romaine.haley@aol.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (317, 'Christia', 'Wilkins', '(415) 789-6543', 'christia.wilkins@msn.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (1035, 'Tangela', 'Hurley', '(503) 321-9876', 'tangela.hurley@msn.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (66, 'Lorrie', 'Becker', '(720) 654-3210', 'lorrie.becker@yahoo.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (1025, 'Daphine', 'Willis', '(845) 987-6543', 'daphine.willis@msn.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (662, 'Loraine', 'Sykes', '(619) 234-5678', 'loraine.sykes@yahoo.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (176, 'Carley', 'Reynolds', '(818) 765-4321', 'carley.reynolds@gmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (825, 'Kristel', 'Byrd', '(310) 876-5432', 'kristel.byrd@hotmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (650, 'Rita', 'Bailey', '(909) 543-2109', 'rita.bailey@hotmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (232, 'Freddie', 'Mathis', '(202) 890-1234', 'freddie.mathis@hotmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (199, 'Clelia', 'Workman', '(315) 765-8901', 'clelia.workman@yahoo.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (846, 'Sylvester', 'Chan', '(423) 987-1230', 'sylvester.chan@hotmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (1109, 'Gussie', 'Harding', '(530) 678-2345', 'gussie.harding@gmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (1396, 'Delma', 'Bailey', '(657) 454-8493', 'delma.bailey@gmail.com');
INSERT INTO Customers (customer_id, first_name, last_name, phone, email) VALUES (359, 'Angie', 'Powers', '(725) 678-5432', 'angie.powers@aol.com');

INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (1.0, 1.0, 1.0, 2.0, 2499.99, 5.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (2.0, 2.0, 2.0, 1.0, 849.99, 0.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (3.0, 3.0, 3.0, 3.0, 2150.0, 10.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (4.0, 4.0, 4.0, 4.0, 129.99, 0.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (5.0, 5.0, 5.0, 1.0, 599.99, 5.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (6.0, 6.0, 6.0, 2.0, 429.99, 8.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (7.0, 7.0, 7.0, 1.0, 4599.99, 15.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (8.0, 8.0, 8.0, 2.0, 1550.0, 12.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (9.0, 9.0, 9.0, 3.0, 249.99, 0.0);
INSERT INTO Order_Items (order_id, item_id, product_id, quantity, list_price, discount) VALUES (10.0, 10.0, 10.0, 5.0, 189.99, 10.0);

INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (1, 414, 1, 1, 'Shipped', '2024-02-01', '2024-02-05', '2024-02-03');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (2, 317, 2, 2, 'Pending', '2024-02-10', '2024-02-15', '2024-02-14');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (3, 1035, 3, 3, 'Delivered', '2024-01-20', '2024-01-25', '2024-01-23');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (4, 66, 1, 4, 'Shipped', '2024-03-05', '2024-03-10', '2024-03-08');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (5, 1025, 2, 5, 'Cancelled', '2024-02-15', '2024-02-20', '2024-02-19');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (6, 662, 3, 6, 'Delivered', '2024-01-18', '2024-01-22', '2024-01-21');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (7, 176, 1, 7, 'Pending', '2024-02-25', '2024-03-02', '2024-03-01');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (8, 825, 2, 8, 'Shipped', '2024-01-30', '2024-02-05', '2024-02-02');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (9, 650, 3, 9, 'Shipped', '2024-03-12', '2024-03-18', '2024-03-16');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (10, 232, 1, 10, 'Delivered', '2024-02-22', '2024-02-28', '2024-02-26');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (11, 199, 2, 1, 'Pending', '2024-03-01', '2024-03-06', '2024-03-05');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (12, 846, 3, 2, 'Shipped', '2024-01-10', '2024-01-15', '2024-01-14');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (13, 1109, 1, 3, 'Delivered', '2024-02-05', '2024-02-12', '2024-02-11');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (14, 1396, 2, 4, 'Cancelled', '2024-01-28', '2024-02-02', '2024-02-01');
INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) VALUES (15, 359, 3, 5, 'Pending', '2024-03-15', '2024-03-20', '2024-03-19');

INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (1, 'Electra Townie Go!', 1, 5, 2023, 2499.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (2, 'Trek Marlin 7', 9, 6, 2022, 849.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (3, 'Surly Big Dummy', 8, 3, 2021, 2150.0);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (4, 'Strider 12 Sport', 6, 1, 2023, 129.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (5, 'Haro Beasley 27.5', 2, 2, 2022, 599.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (6, 'Electra Cruiser 1', 1, 3, 2022, 429.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (7, 'Trek Powerfly FS 4', 9, 5, 2023, 4599.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (8, 'Surly Karate Monkey', 8, 6, 2021, 1550.0);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (9, 'Haro Shredder 16', 2, 1, 2023, 249.99);
INSERT INTO Products (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES (10, 'Strider 14x Sport', 6, 1, 2022, 189.99);

INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (1, 'Fabiola', 'Jackson', 'fabiola.jackson@bikes.shop', '(831) 555-5554', 1, 1, 1.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (2, 'Mireya', 'Copeland', 'mireya.copeland@bikes.shop', '(831) 555-5555', 1, 1, 1.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (3, 'Genna', 'Serrano', 'genna.serrano@bikes.shop', '(831) 555-5556', 1, 1, 1.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (4, 'Virgie', 'Wiggins', 'virgie.wiggins@bikes.shop', '(831) 555-5557', 1, 1, 2.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (5, 'Jannette', 'David', 'jannette.david@bikes.shop', '(516) 379-4444', 1, 2, 1.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (6, 'Marcelene', 'Boyer', 'marcelene.boyer@bikes.shop', '(516) 379-4445', 1, 2, 5.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (7, 'Venita', 'Daniel', 'venita.daniel@bikes.shop', '(516) 379-4446', 1, 2, 5.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (8, 'Kali', 'Vargas', 'kali.vargas@bikes.shop', '(972) 530-5555', 1, 3, 1.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (9, 'Layla', 'Terrell', 'layla.terrell@bikes.shop', '(972) 530-5556', 1, 3, 8.0);
INSERT INTO Staff (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES (10, 'Bernardine', 'Houston', 'bernardine.houston@bikes.shop', '(972) 530-5557', 1, 3, 8.0);

INSERT INTO Stocks (store_id, product_id, quantity) VALUES (1, 1, 15);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (1, 2, 10);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (1, 3, 8);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (2, 4, 20);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (2, 5, 12);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (2, 6, 18);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (3, 7, 5);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (3, 8, 9);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (3, 9, 14);
INSERT INTO Stocks (store_id, product_id, quantity) VALUES (3, 10, 11);

INSERT INTO Stores (store_id, store_name, phone, email) VALUES (1, 'Santa Cruz Bikes', '(831) 476-4321', 'santacruz@bikes.shop');
INSERT INTO Stores (store_id, store_name, phone, email) VALUES (2, 'Baldwin Bikes', '(516) 379-8888', 'baldwin@bikes.shop');
INSERT INTO Stores (store_id, store_name, phone, email) VALUES (3, 'Rowlett Bikes', '(972) 530-5555', 'rowlett@bikes.shop');

INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (1, '123 Main St', 'New York', 'NY', '10001');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (2, '456 Elm St', 'Los Angeles', 'CA', '90001');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (3, '789 Pine St', 'Chicago', 'IL', '60601');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (4, '321 Oak St', 'Houston', 'TX', '77001');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (5, '654 Maple St', 'San Francisco', 'CA', '94101');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (6, '987 Birch St', 'Boston', 'MA', '02101');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (7, '741 Cedar St', 'Seattle', 'WA', '98101');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (8, '159 Walnut St', 'Denver', 'CO', '80201');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (9, '852 Chestnut St', 'Miami', 'FL', '33101');
INSERT INTO Locations (location_id, street, city, state, zip_code) VALUES (10, '369 Hickory St', 'Atlanta', 'GA', '30301');

INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (1, 414, 1, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (2, 317, 2, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (3, 1035, 3, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (4, 66, 4, 'Work');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (5, 1025, 5, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (6, 662, 6, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (7, 176, 7, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (8, 825, 8, 'Work');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (9, 650, 9, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (10, 232, 10, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (11, 199, 1, 'Work');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (12, 846, 2, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (13, 1109, 3, 'Home');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (14, 1396, 4, 'Work');
INSERT INTO Customer_Locations (customer_location_id, customer_id, location_id, address_type) VALUES (15, 359, 5, 'Home');

INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (1, 1, 1, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (2, 2, 2, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (3, 3, 3, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (4, 1, 4, 'Warehouse');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (5, 2, 5, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (6, 3, 6, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (7, 1, 7, 'Warehouse');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (8, 2, 8, 'Retail');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (9, 3, 9, 'Warehouse');
INSERT INTO Store_Locations (store_location_id, store_id, location_id, store_type) VALUES (10, 1, 10, 'Retail');