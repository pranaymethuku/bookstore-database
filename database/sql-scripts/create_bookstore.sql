/* 
  Schema for creating Bookstore database
  Tables - 
    Warehouse - (id*, city, zip)
    Source - (id*, s_name)
    Publisher - (id*, p_name, city, zip)
    Customer - (id*, c_name, c_email)
    Media - (id*, pub_id **, title, price, category, quantity, m_link, prod_year, filesize)
    Book - (id*, pub_id **, title, price, category, quantity, b_format, prod_year, filesize)
    Checkout - (id*, c_id **, ch_type, ch_date)
    PublisherPhone - (pub_phone*, pub_id **)
    CustomerPhone - (cust_phone*, c_id **)
    ProductCheckout - (id*, prod_id **, ch_id **)
    WarehouseProduct - (id*, w_id **, prod_id **)
    SourceProduct - (id*, s_id **, prod_id **)

    * - Primary key
    ** - Foreign key
 */
PRAGMA foreign_keys = ON;

CREATE TABLE Warehouse (
  id int NOT NULL,
  city varchar(20) NOT NULL,
  zip varchar(10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Source (
  id int NOT NULL,
  s_name varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Publisher (
  id int NOT NULL,
  p_name varchar(40) NOT NULL,
  city varchar(20) NOT NULL,
  zip varchar(10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Customer (
  id int NOT NULL,
  c_name varchar(20) NOT NULL,
  c_email varchar(40) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Media (
  id varchar(20) NOT NULL,
  pub_id int NOT NULL,
  title varchar(100) NOT NULL,
  price real NOT NULL,
  category varchar(30),
  quantity int NOT NULL DEFAULT 10,
  m_link varchar(40),
  prod_year int NOT NULL,
  filesize int,
  PRIMARY KEY (id),
  FOREIGN KEY (pub_id) REFERENCES Publisher(id) ON DELETE CASCADE
);

CREATE TABLE Book (
  id varchar(20) NOT NULL,
  pub_id int NOT NULL,
  title varchar(100) NOT NULL,
  price real NOT NULL,
  category varchar(30),
  quantity int NOT NULL DEFAULT 10,
  b_format varchar(40),
  prod_year int NOT NULL,
  filesize int,
  PRIMARY KEY (id),
  FOREIGN KEY (pub_id) REFERENCES Publisher(id) ON DELETE CASCADE
);

CREATE TABLE Checkout (
  id int NOT NULL,
  c_id int NOT NULL,
  ch_type varchar(15),
  ch_date date NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (c_id) REFERENCES Customer(id) ON DELETE CASCADE
);

CREATE TABLE PublisherPhone (
  pub_phone varchar(15) NOT NULL,
  pub_id int NOT NULL,
  PRIMARY KEY (pub_phone),
  FOREIGN KEY (pub_id) REFERENCES Publisher(id) ON DELETE CASCADE
);

CREATE TABLE CustomerPhone (
  cust_phone varchar(15) NOT NULL,
  c_id int NOT NULL,
  PRIMARY KEY (cust_phone),
  FOREIGN KEY (c_id) REFERENCES Customer(id) ON DELETE CASCADE
);

CREATE TABLE ProductCheckout (
  id int NOT NULL,
  prod_id varchar(20) NOT NULL,
  ch_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (prod_id) REFERENCES Book(id) ON DELETE CASCADE,
  FOREIGN KEY (ch_id) REFERENCES Checkout(id) ON DELETE CASCADE
);

CREATE TABLE WarehouseProduct (
  id int NOT NULL,
  w_id int NOT NULL,
  prod_id varchar(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (w_id) REFERENCES Warehouse(id) ON DELETE CASCADE,
  FOREIGN KEY (prod_id) REFERENCES Book(id) ON DELETE CASCADE
);

CREATE TABLE SourceProduct (
  id int NOT NULL,
  s_id int NOT NULL,
  prod_id varchar(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (s_id) REFERENCES Source(id) ON DELETE CASCADE,
  FOREIGN KEY (prod_id) REFERENCES Book(id) ON DELETE CASCADE
);
