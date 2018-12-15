# Bits & Books Online Bookstore Database

Bits & Books, an online bookstore, needs a simple information management system and database to support their inventory and sales operations.

## Project File Structure

### `database` - Folder for files related to the database

* `ER_diagram.pdf` - Entity Relationship Diagram PDF for the database

* `bookstore.db` - A binary version of the database, suitable for opening using either the sqlite3 command line tool or the Firefox SQLite Admin tool.

* `sql-scripts` - Folder that contains all required SQL code for the final report, to be executed by pasting into an sqlite command prompt (or loaded from the command line tool)
  * `create_bookstore.sql` - SQL file to create the database schema on an empty database
  * `create_views.sql` - SQL file to create views in the database
  * `insert_data.sql` - SQL file to insert all data (both the sample and some fake generated data) in the database
  * `sample_queries.sql` - SQL file to run all the queries used in the final report from Part I.
  * `sample_insert_delete.sql` - SQL file containing all the sample INSERT and DELETE statements provided in the user manual, suitable for pasting into a command prompt and testing the result on the database.

* `sample-data` - Folder that contains data and scripts for populating the database
  * `proj_data.csv` - Sample CSV data file to insert data into the database
  * `proj_data.xlsx` - Sample spreadsheet data file to insert data into the database
  * `database_populator.py` - `Python 2.7` script which uses the `proj_data.csv` file for book, author, and publisher data, and the module `faker` to generate fake customer and order data.

### `bash-scripts` - Folder containing bash scripts to automate some commands

The following scripts can be run on a Linux environment, and have been used to test the database.

* The script `refresh-database.sh` can be used to create the database and insert all data in one go, presumably if all dependency files exist, and the file structure is not changed.

* The bash script `run-queries.sh` can be used to run the `sample_queries.sql` file and generate the result.
