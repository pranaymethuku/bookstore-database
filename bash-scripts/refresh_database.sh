#!/bin/bash
# Created by: Pranay Methuku
# Created at: October 26, 2018

# Running the same sequence of command line instructions every time 
# the database_populator.py file is changed
cd ../database/sample-data/
python database_populator.py > ../sql-scripts/insert_data.sql
cd ../
rm -f bookstore.db
cd sql-scripts
cat create_bookstore.sql insert_data.sql create_views.sql sample_transactions.sql | sqlite3 ../bookstore.db
