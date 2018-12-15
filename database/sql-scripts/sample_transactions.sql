/*
 Interesting transactions that can be run in the database
*/

/*
 Add a completely new Book with a new Author and Publisher (and their phone number), 
 none of which exist in the database
*/
BEGIN TRANSACTION;
  -- inserting author data into Source table first
  INSERT INTO Source (id, s_name) VALUES 
    (1000, "J. K. Rowling");
  -- inserting publisher data into Publisher table
  INSERT INTO Publisher (id, p_name, city, zip) VALUES 
    (1000, "Bloomsbury", "London", 83289);
  -- inserting publisher phone data into PublisherPhone table
  INSERT INTO PublisherPhone (pub_phone, pub_id) VALUES 
    ("(800)-289-2891", 1000);
  -- inserting book data into Book table
  INSERT INTO Book (id, title, pub_id, prod_year, price, category, quantity, b_format, filesize) VALUES 
    ("0-7475-3269-9", "Harry Potter and the Philosopher's Stone", 1000, 1997, 24.95, "Fiction", 20, "epub", 3188);
  -- inserting relationship between Source (author) and Product (book/media) table
  INSERT INTO SourceProduct (id, prod_id, s_id) VALUES 
    (1000, "0-7475-3269-9", 1000);
COMMIT;

/*
 A new customer just bought a book, so they need to be added to the database, 
 along with their phone number and Checkout information
*/
BEGIN TRANSACTION;
  -- inserting new customer data into Customer table
  INSERT INTO Customer (id, c_name, c_email) VALUES 
    (1000, "Pranay Methuku", "pranaymethuku@gmail.com");
  -- inserting customer phone data into CustomerPhone table
  INSERT INTO CustomerPhone (cust_phone, c_id) VALUES 
    ("(614)-192-2891", 1000),
    ("(614)-192-2910", 1000);
  -- inserting checkout data into Checkout table
  INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES 
    (1901, 1000, "Coupon", "2018-12-02");
  -- inserting product data for each checkout into ProductCheckout table
  INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES 
    (1230, "0471358983", 1901),
    (1231, "0670031518", 1901),
    (1232, "0130998516", 1901);
  UPDATE Book SET quantity = quantity - 1 WHERE 
    id = "0471358983" OR 
    id = "0670031518" OR 
    id = "0130998516";
COMMIT;

/* 
  An existing customer wants to return their purchased books.
*/
BEGIN TRANSACTION;
  INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES 
    (1902, 1000, "Refund", "2018-12-04");
  -- inserting product data for each checkout into ProductCheckout table
  INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES 
    (1234, "0471358983", 1902),
    (1235, "0670031518", 1902);
  UPDATE Book SET quantity = quantity + 1 WHERE 
    id = "0471358983" OR 
    id = "0670031518"; 
COMMIT;