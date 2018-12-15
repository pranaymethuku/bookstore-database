/*
 Sample Queries from Checkpoints 2 and 3
*/

-- finds all titles of books by Pratchett that cost less than $50
SELECT b.title 
FROM Book b, Source s, SourceProduct sp 
WHERE b.id = sp.prod_id AND s.id = sp.s_id AND s_name="Pratchett" AND b.price < 50;

-- finds all the book titles and their dates of purchase made by a customer with id = 1
SELECT b.title, ch_date 
FROM Customer c, Checkout ch, ProductCheckout pc, Book b 
WHERE c.id = 1 AND c.id = ch.c_id AND ch.id = pc.ch_id AND b.id = pc.prod_id;

-- finds the titles and ISBNs for all books with less than 15 copies in stock
SELECT title, id
FROM Book 
WHERE quantity < 15;

-- finds all the customers who purchased a book by Pratchett and the 
--  titles of Pratchett books they purchased
SELECT c_name, c.id, b.title 
FROM Customer c, Book b, Checkout ch, ProductCheckout pc, Source s, SourceProduct sp 
WHERE c.id = ch.c_id AND b.id = pc.prod_id AND ch.id = pc.ch_id AND s.id = sp.s_id AND
 sp.prod_id = b.id AND s_name = "Pratchett";

-- finds total number of books purchased by a single customer with customer id = 1
SELECT c_name, count(b.id) 
FROM Customer c, Checkout ch, ProductCheckout pc, Book b 
WHERE c.id = 1 AND c.id = ch.c_id AND ch.id = pc.ch_id AND b.id = pc.prod_id 
GROUP BY c.id;

-- finds the customer who has purchased the most books and the 
--  total number of books they have purchased
SELECT c.id, c_name, count(b.id)  
FROM Customer c, Checkout ch, ProductCheckout pc, Book b 
WHERE c.id = ch.c_id AND ch.id = pc.ch_id AND b.id = pc.prod_id 
GROUP BY c.id
ORDER BY count(b.id) DESC
LIMIT 1;
