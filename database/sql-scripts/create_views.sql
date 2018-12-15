/*
 Interesting Views that can be generated from the database
*/

-- For a particular book, see how much revenue the book has generated.
CREATE VIEW BookRevenue (ISBN, book_name, revenue) AS
SELECT b.id, b.title, b.price * COUNT(pc.id) 
FROM Book b, ProductCheckout pc
WHERE pc.prod_id = b.id
GROUP BY b.id;

-- For a particular author, see how much revenue they have generated to the bookstore.
CREATE VIEW AuthorRevenue (author_id, author_name, revenue) AS
SELECT s.id, s_name, b.price * COUNT(pc.ch_id) 
FROM Source s, SourceProduct sp, Book b, ProductCheckout pc
WHERE s.id = sp.s_id AND sp.prod_id = b.id AND b.id = pc.prod_id
GROUP BY s.id;
