'''
  Created by: Pranay Methuku
  Created on: October 25, 2018

  Python 2.7 script that parses given given csv file for the bookstore database 
  and generates SQL data population code.
'''

import csv, random
from faker import Faker

with open('proj_data.csv', mode='r') as csv_file:
  csv_data = csv.reader(csv_file)
  
  # Set up lists for relations
  authors = []
  publishers = []
  books = []
  book_authors = {}
  customers = []
  checkouts = []

  # Read all rows to register data
  # Row contains attributes ISBN, Title, Author(s), Publisher, Year, Price, Category
  for row in csv_data:
    authors.append(row[2].strip())
    publishers.append(row[3].strip())
    books.append((row[0], row[1], row[3], row[4], row[5], row[6]))
    if row[0] == "ISBN": continue
    if row[0] != "":
      current_ISBN = row[0]
      book_authors.setdefault(current_ISBN, [row[2].strip()])
    else :
      book_authors[current_ISBN].append(row[2].strip())

  # Clean up lists
  authors.remove(authors[0])
  publishers.remove(publishers[0])
  books.remove(books[0])

  # Print block comment at the top of the output

  print("/*\n SQL code to insert data from given csv file and other sample \n \
  fake generated data into database for testing queries \n*/")

  # Insert all authors
  authors = list(set(authors))
  print("-- inserting author data into Source table from given sample file")
  print("INSERT INTO Source (id, s_name) VALUES ")
  for author_id in range(1, len(authors) + 1):
    separator = ';\n' if author_id == len(authors) else ','
    print('  ({0}, "{1}"){2}'.format(author_id, authors[author_id - 1], separator))

  # Insert all publishers
  publishers = list(set(publishers))
  publishers.remove("") # some rows are not books
  print("-- inserting publisher data into Publisher table from given sample file")
  print("INSERT INTO Publisher (id, p_name, city, zip) VALUES ")
  for publisher_id in range(1, len(publishers) + 1):
    separator = ';\n' if publisher_id == len(publishers) else ','
    print('  ({0}, "{1}", "Columbus", 43210){2}'
      .format(publisher_id, publishers[publisher_id - 1], separator))

  # Insert all books
  # Given - ISBN, Title, Publisher, Year, Price, Category
  # Convert to - id, title, pub_id, prod_year, price, category, b_format
  books = list(set(books))
  print("-- inserting book data into Book table from given sample file")
  print("INSERT INTO Book (id, title, pub_id, prod_year, price, category, quantity, b_format, filesize) VALUES ")
  for book in books:
    separator = ';\n' if book == books[len(books) - 1] else ','
    if book[0] == "":
      continue
    print('  ("{0}", "{1}", {2}, {3}, {4}, "{5}", {6}, "{7}", {8}){9}'
      .format(
        book[0], # id
        book[1], # title
        publishers.index(book[2].strip()) + 1, # prod_id
        book[3], # prod_year
        book[4][1:], # remove the $ sign in front of the price
        book[5], # category,
        random.randint(1, 100), # quantity,
        random.choice(["pdf", "epub", "leaflet", "hardcover"]),
        random.randint(0, 10000), # filesize (KB)
        separator
      )
    ) 

  # Insert relationship between books and authors
  print("-- inserting relationship between Source (author) and Product (book/media) table from given sample file")
  print("INSERT INTO SourceProduct (id, prod_id, s_id) VALUES ")
  book_count = 1
  idx = 1
  for book_ISBN, author_list in book_authors.items():
    for author in author_list:
      separator = ';\n' if (book_count == len(book_authors.items()) and \
        (author == author_list[len(author_list) - 1])) else ','
      print('  ({0}, "{1}", {2}){3}'.format(idx, book_ISBN, authors.index(author) + 1, separator))
      idx += 1
    book_count += 1

  # Insert fake data from Faker
  fake = Faker()

  # Insert random customers
  print("-- inserting fake customer data into Customer table")
  print("INSERT INTO Customer (id, c_name, c_email) VALUES ")
  for i in range(1, 101):
    c_name =  fake.name()
    customers.append(c_name)
    separator = ';\n' if i == 100 else ','
    print('  ({0}, "{1}", "{2}"){3}'
      .format(
        i, 
        c_name, 
        ("".join(str(c_name).split(" "))).lower() + "@gmail.com",
        separator
      )
    )

  # Generate Checkouts with Customers and Products
  ch_types = ["Credit card", "Cash on Delivery", "Paypal", "Coupon", "Gift card", "Refund"]
  for i in range(1, 301):
    ch_date = str(fake.date_between(start_date="-1y", end_date="today"))
    c_id = random.randint(1, 100)
    ch_type = random.choice(ch_types)
    # Get the ISBNs of k random books where k is a random integer between 1 and 5 inclusive
    book_ISBNs = [books[idx][0] for idx in random.sample(range(len(books)), random.randint(1, 5))]
    if "" in book_ISBNs: book_ISBNs.remove("")
    checkouts.append((i, c_id, ch_type, ch_date, book_ISBNs))

  # Insert Checkouts
  print("-- inserting fake checkout data into Checkout table")
  print("INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES ")
  for checkout in checkouts:
    separator = ';\n' if checkout == checkouts[len(checkouts) - 1] else ','
    print('  ({0}, {1}, "{2}", "{3}"){4}'
      .format(
        checkout[0], # id
        checkout[1], # customer id
        checkout[2], # checkout type
        checkout[3], # checkout date
        separator
      )
    )

  # Insert Checkouts
  print("-- inserting fake product data for each checkout into ProductCheckout table")
  print("INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES ")
  checkout_count = 1
  idx = 1
  for ch_id, _, _, _, prod_list  in checkouts:
    for prod_id in prod_list:
      separator = ';\n' if (checkout_count == len(checkouts) and \
        (prod_id == prod_list[len(prod_list) - 1])) else ','
      print('  ({0}, "{1}", {2}){3}'.format(idx, prod_id, ch_id, separator))
      idx += 1
    checkout_count += 1

