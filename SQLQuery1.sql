USE SAMWEBSTER -- choose DB to use
GO

-- Drop old tables
DROP TABLE car_model, manufacturer, manu_hq, factory, dealer, car_offer, picture, review;

GO
-- Create Tables
CREATE TABLE car_model(
	id				int,
	rrp				decimal(8,2),
	name			varchar(20),
	manu_id			int
);

CREATE TABLE manufacturer(
	id				int,
	name			varchar(20),
	description		varchar(250),
	vat_reg			varchar(15)
);

CREATE TABLE manu_hq(
	id				int,
	manu_id			int,
	address			varchar(120), -- this will be the full address of the head quarters
	postcode		varchar(10),
	phone_number	varchar(20)
);

CREATE TABLE factory(
	id				int,
	hq_id			int,
	address			varchar(120), -- this will be the full address of the factory
	postcode		varchar(10),
	phone_number	varchar(20)
);

CREATE TABLE dealer(
	id				int,
	name			varchar(25),
	address			varchar(120), -- this will be the full address of the factory
	postcode		varchar(10),
	phone_number	varchar(20),
	email			varchar(50),
	rating			decimal(3,2)
);

CREATE TABLE car_offer(
	id				int,
	cm_id			int, -- id of car_model
	dealer_id		int,
	price			decimal(8,2),
	year_of_manu	int,
	reg_num			varchar(8), -- think this is max length
	condition		varchar(30),
	description		varchar(250)
);
	
CREATE TABLE picture(
	id				int,
	co_id			int,
	img_loc			varchar(40)
);

CREATE TABLE review(
	id				int,
	cm_id			int,
	rating			int, -- out of 10
	content			varchar(250)
);
GO



INSERT INTO car_model
VALUES 
(0, 125000.09, 'Mercades SLR', 4),
(1, 1345.65, 'Peugeot 107', 1),
(2, 1678.99, 'Ford Focus', 2),
(3, 2578.00, 'Peugeot 307', 1),
(4, 900.00, 'Vauxhall Vectra', 3),
(5, 25000.00, 'BMW One', 0);

INSERT INTO manufacturer
VALUES
(0, 'BMW', 'An expensive british car manufacturer who specialise in cars without indicators', 'GB342561706'),
(1, 'Peugeot', 'A french car manufacturer', 'FR1245679280'),
(2, 'Ford', 'An american car manufacturer started by Henry Ford', 'US237896016'),
(3, 'Vauxhall', 'An american car manufacturer started by Henry Ford', 'US237896016'),
(4, 'Ford', 'An american car manufacturer started by Henry Ford', 'US237896016'); -- duplication of id 2

INSERT INTO car_offer
VALUES
(0, 1, 0, 950.00, 2006, 'AO06 JBO', 'Good Condition', 'This car is pink'),
(1, 3, 0, 1925.00, 2009, 'BN09 STD', 'Good Condition', 'This car is blue'),
(2, 2, 0, 1000.00, 2004, 'RG04 QBO', 'Good Condition', 'This car is gold'),
(3, 1, 1, 980.00, 2007, 'QD07 FSA', 'Good Condition', 'This car is silver'),
(4, 2, 1, 780.00, 2005, 'YJ05 WDO', 'Poor Condition', 'This car is needs a gearbox'),
(5, 5, 2, 19500.00, 2017, 'IM17 BAD', 'Like New', 'This car is very fast and has no indicators');



INSERT INTO dealer (id, name, address, postcode, phone_number, email, rating)
VALUES
(0, 'Dodgy Dave', '1 The Street, London, UK', 'LO21 4TH', '01234 567890', 'dodgydave@gmail.com', 1),
(1, 'Coopers Cars', '2 The Street, London, UK', 'LO21 4TH', '01234 427890', 'cooperscars@gmail.com', 4),
(2, 'Arao and Sons', '3 The Street, London, UK', 'LO21 4TH', '01234 522890', 'araoandsons@gmail.com', 3);
GO

UPDATE manufacturer -- I duplicated ford so I am overwriting it
SET name = 'Mercades', description = 'A car company which represents the pinnacle of german engineering', vat_reg = 'GE1234567890'
WHERE id = 4;
GO

DELETE car_model;
GO

/* SQL #1
SELECT statement which returns car model, RRP and manufacturer*/
SELECT car_model.name, car_model.rrp, manufacturer.name  
FROM car_model INNER JOIN manufacturer
ON car_model.manu_id = manufacturer.id
ORDER BY car_model.rrp DESC;
GO

SELECT dealer.name as 'dealer', manufacturer.name as 'manufacturer', car_model.name as 'model', car_offer.year_of_manu as 'year', car_offer.condition,  car_offer.price, car_model.rrp
FROM car_offer
INNER JOIN car_model
ON car_offer.cm_id = car_model.id
INNER JOIN manufacturer
ON manufacturer.id = car_model.manu_id
INNER JOIN dealer
ON dealer.id = car_offer.dealer_id
WHERE dealer.name = 'Dodgy Dave'
ORDER BY 'year';


