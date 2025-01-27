-- Set mode to CSV for imports
.mode csv

-- Drop and recreate the Users table
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id TEXT,
    created_date DATETIME,
    birth_date DATETIME,
    state VARCHAR,
    language VARCHAR,
    gender VARCHAR
);
-- Import data into the Users table
.import data/processed/users_cleaned.csv Users

-- Drop and recreate the Products table
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    category_1 VARCHAR,
    category_2 VARCHAR,
    category_3 VARCHAR,
    category_4 VARCHAR,
    manufacturer VARCHAR,
    brand VARCHAR,
    barcode TEXT
);
-- Import data into the Products table
.import data/processed/products_cleaned.csv Products

-- Drop and recreate the Transactions table
DROP TABLE IF EXISTS Transactions;

CREATE TABLE Transactions (
    receipt_id TEXT,
    purchase_date DATETIME,
    scan_date DATETIME,
    store_name VARCHAR,
    user_id TEXT,
    barcode TEXT,
    quantity NUMERIC,
    sale NUMERIC,
    FOREIGN KEY (user_id) REFERENCES Users (id),
    FOREIGN KEY (barcode) REFERENCES Products (barcode)
);

-- Import data into the Transactions table
.import data/processed/transactions_cleaned.csv Transactions