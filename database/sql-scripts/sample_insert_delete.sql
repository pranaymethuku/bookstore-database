/*
 Sample SQL code to insert and delete data into the database 
*/
-- inserting author data into Source table from given sample file
INSERT INTO Source (id, s_name) VALUES 
  (2000, "Ken Henderson");
  
-- inserting publisher data into Publisher table from given sample file
INSERT INTO Publisher (id, p_name, city, zip) VALUES 
  (2000, "Silhouette", "Columbus", 43210);

-- inserting book data into Book table from given sample file
INSERT INTO Book (id, title, pub_id, prod_year, price, category, quantity, b_format, filesize) VALUES 
  ("156158648X0", "The New City Home: Smart Solutions for Metro Living", 61, 2003, 24.95, "Home Design", 20, "epub", 3188);

-- inserting relationship between Source (author) and Product (book/media) table from given sample file
INSERT INTO SourceProduct (id, prod_id, s_id) VALUES 
  (2000, "156158648X0", 96);

-- inserting fake customer data into Customer table
INSERT INTO Customer (id, c_name, c_email) VALUES 
  (2000, "William Gardner", "williamgardner@gmail.com");

-- inserting fake checkout data into Checkout table
INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES 
  (2000, 24, "Paypal", "2017-11-22");

-- inserting fake product data for each checkout into ProductCheckout table
INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES 
  (2000, "0130323519", 1);

-- deleting author data from Source table
DELETE FROM Source WHERE id = 2000;

-- deleting publisher data from Publisher table
DELETE FROM Publisher WHERE id = 2000;

-- deleting book data from Book table
DELETE FROM Book WHERE id = "156158648X0";

-- deleting relationship between Source (author) and Product (book/media) table
DELETE FROM SourceProduct WHERE id = "04402375560";

-- deleting customer data from Customer table
DELETE FROM Customer WHERE id = 2000;
