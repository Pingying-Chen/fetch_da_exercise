#!/bin/bash

# Define the database name
DB_NAME="./data/fetch_data.db"

# Ensure the directory for the database exists
mkdir -p ./data

# Delete the database if it exists (to ensure a fresh start)
rm -f "$DB_NAME"

# Import CSV data into the database
sqlite3 "$DB_NAME" <<EOF
-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Set mode to CSV
.mode csv

-- Import CSV data into automatically created tables
.import data/processed/users_cleaned.csv Users
.import data/processed/products_cleaned.csv Products
.import data/processed/transactions_cleaned.csv Transactions
EOF

# Confirmation message
echo "Database '$DB_NAME' created successfully with data from 'Users', 'Products', and 'Transactions' CSV files."