#!/bin/bash

# Define the database name
DB_NAME="./data/fetch_data.db"

# Ensure the directory for the database exists
mkdir -p ./data

# Delete the database if it exists (to ensure a fresh start)
rm -f "$DB_NAME"

# Create the database schema
sqlite3 "$DB_NAME" <<EOF
-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Create the Users table with DATETIME types
CREATE TABLE Users (
    ID TEXT,
    CREATED_DATE DATETIME,
    BIRTH_DATE DATETIME,
    STATE TEXT,
    LANGUAGE TEXT,
    GENDER TEXT
);

-- Create the Products table (schema unchanged)
CREATE TABLE Products (
    CATEGORY_1 TEXT,
    CATEGORY_2 TEXT,
    CATEGORY_3 TEXT,
    CATEGORY_4 TEXT,
    MANUFACTURER TEXT,
    BRAND TEXT,
    BARCODE TEXT
);

-- Create the Transactions table with DATETIME types
CREATE TABLE Transactions (
    RECEIPT_ID TEXT,
    PURCHASE_DATE DATETIME,
    SCAN_DATE DATETIME,
    STORE_NAME TEXT,
    USER_ID TEXT,
    BARCODE TEXT,
    final_quantity TEXT,
    final_sale TEXT
);
EOF

# Import CSV data into the database, skipping headers
sqlite3 "$DB_NAME" <<EOF
-- Set mode to CSV
.mode csv

-- Ensure empty strings are treated as NULL
.nullvalue NULL

-- Import data while skipping the header row
.import --skip 1 data/processed/users_cleaned.csv Users
.import --skip 1 data/processed/products_cleaned.csv Products
.import --skip 1 data/processed/transactions_cleaned.csv Transactions
EOF

# Confirmation message
echo "Database '$DB_NAME' created successfully with corrected schema and blank CSV values imported as NULL, while skipping CSV headers."