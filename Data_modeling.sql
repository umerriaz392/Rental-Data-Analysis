DROP TABLE FACT_rental;
DROP TABLE Dim_Location;
DROP TABLE Dim_Host;
DROP TABLE Dim_Property;
DROP TABLE Dim_CanPolicy;

CREATE TABLE Dim_Host
(	host_id BIGINT primary key,
	host_name VARCHAR(50),
	host_identity_verified VARCHAR(50)
)

CREATE TABLE Dim_Location
(	location_id INT IDENTITY(1,1) primary key,
	neighbourhood VARCHAR(50),
	neighbourhood_group VARCHAR(50),
	country VARCHAR(50),
	country_code VARCHAR(5),
	lat float,
	long float
)

CREATE TABLE Dim_Property
(	property_id INT IDENTITY(1,1) primary key,
	name NVARCHAR(MAX),
	room_type VARCHAR(50),
	construction_year INT
)

CREATE TABLE Dim_CanPolicy
(	policy_id INT IDENTITY(1,1) primary key,
	cancellation_policy VARCHAR(50)
)

Create TABLE Fact_rental
(	id INT primary key,
	host_id BIGINT References Dim_Host(host_id),
	property_id INT References Dim_Property(property_id),
	location_id INT References Dim_Location(location_id),
	policy_id INT References Dim_CanPolicy(policy_id),
	Price FLOAT,
	Service_Fee FLOAT,
	Minimum_nights INT,
	number_of_reviews INT,
	reviews_per_month FLOAT,
	reviews_rate_number INT,
	last_review_date DATE,
	calculated_host_listings_count INT,
	instant_bookable BIT,
	availability_365 INT 
)

INSERT INTO Dim_Host(host_id ,host_name ,host_identity_verified)
SELECT host_id,host_name,host_identity_verified 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY host_id ORDER by host_id) rown, host_id,host_name,host_identity_verified 
FROM rental) AS unique_records
WHERE rown=1

INSERT INTO Dim_Location(neighbourhood, neighbourhood_group, country, country_code, lat, long)
SELECT DISTINCT neighbourhood, neighbourhood_group, country, country_code, lat, long 
FROM rental

INSERT INTO Dim_Property(name, room_type, construction_year)
SELECT DISTINCT name, room_type, construction_year 
FROM rental

INSERT INTO Dim_CanPolicy(cancellation_policy)
SELECT DISTINCT cancellation_policy 
FROM rental

INSERT INTO Fact_Rental
(id, host_id, property_id, location_id, policy_id, Price, Service_Fee, Minimum_nights, 
 number_of_reviews, reviews_per_month, reviews_rate_number, last_review_date, 
 calculated_host_listings_count, instant_bookable, availability_365)
SELECT 
    r.id, h.host_id, p.property_id, l.location_id, c.policy_id, r.price, r.service_fee, r.minimum_nights,
    r.number_of_reviews, r.reviews_per_month, r.review_rate_number, r.last_review,
    r.calculated_host_listings_count, r.instant_bookable, r.availability_365
FROM rental r
 JOIN Dim_Host h 
    ON r.host_id = h.host_id
 JOIN Dim_Property p 
    ON  r.NAME = p.name
   AND r.room_type = p.room_type
   AND ISNULL(r.construction_year,0) = ISNULL(p.construction_year,0)
 JOIN Dim_Location l 
    ON r.neighbourhood = l.neighbourhood
   AND r.neighbourhood_group = l.neighbourhood_group
   AND r.country = l.country
   AND r.country_code = l.country_code
   AND ISNULL(r.lat,0) = ISNULL(l.lat,0)
   AND ISNULL(r.long,0) = ISNULL(l.long,0)
 JOIN Dim_CanPolicy c 
    ON r.cancellation_policy = c.cancellation_policy

	SELECT * FROM Fact_rental
	SELECT * FROM Dim_Property

	SELECT @@SERVERNAME
