#!/bin/bash

# Define the database name
DB_NAME="./data/fetch_data.db"

# Ensure the directory for the database exists
mkdir -p ./data

# Create the database and tables
sqlite3 "$DB_NAME" <<EOF
-- Enable foreign key support
PRAGMA foreign_keys = ON;

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
EOF

# Import CSV data into the tables
sqlite3 "$DB_NAME" <<EOF
.mode csv
.import data/processed/users_cleaned.csv Users
.import data/processed/products_cleaned.csv Products
.import data/processed/transactions_cleaned.csv Transactions
EOF

# Confirmation message
echo "Database '$DB_NAME' created successfully with 'Users', 'Products', and 'Transactions' tables."