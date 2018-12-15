#!/bin/bash
# Created by: Pranay Methuku
# Created at: November 21, 2018

# Run the sample queries file from existing database
cd ../database
sqlite3 bookstore.db < ./sql-scripts/sample_queries.sql
