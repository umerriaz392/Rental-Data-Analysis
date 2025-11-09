--DELETE Duplicates
DELETE duplicate 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY id ORDER BY id ASC) AS row_num, * FROM rental) AS duplicate
WHERE row_num>1

UPDATE rental
SET country_code = 'US'
WHERE country = 'United States' AND country_code IS NULL

UPDATE rental
SET country = 'United States'
WHERE country_code = 'US' AND country IS NULL
                             --------

UPDATE rental
SET NAME = 'Unknown'
WHERE NAME IS NULL;

UPDATE rental
SET host_identity_verified = 'unconfirmed'
WHERE host_identity_verified IS NULL;

UPDATE rental
SET host_name = 'unknown host'
WHERE host_name IS NULL;

UPDATE rental
SET neighbourhood_group = 'unknown group'
WHERE neighbourhood_group IS NULL;

UPDATE rental
SET neighbourhood = 'unknown'
WHERE neighbourhood IS NULL;


UPDATE rental
SET country = 'unknown'
WHERE country IS NULL;

UPDATE rental
SET country_code = 'UNK'
WHERE country_code IS NULL;

UPDATE rental
SET instant_bookable = 0
WHERE instant_bookable IS NULL;

UPDATE rental
SET cancellation_policy = 'unknown'
WHERE cancellation_policy IS NULL;

UPDATE rental
SET room_type = 'unknown'
WHERE room_type IS NULL;

UPDATE rental
SET price = 0
WHERE price IS NULL;

UPDATE rental
SET service_fee = 0
WHERE service_fee IS NULL;

UPDATE rental
SET minimum_nights = 0
WHERE minimum_nights IS NULL;

UPDATE rental
SET number_of_reviews = 0
WHERE number_of_reviews IS NULL;

UPDATE rental
SET review_rate_number = 0
WHERE review_rate_number IS NULL;

UPDATE rental
SET reviews_per_month = 0
WHERE reviews_per_month IS NULL;

UPDATE rental
SET calculated_host_listings_count = 0
WHERE calculated_host_listings_count IS NULL;

UPDATE rental
SET availability_365 = 0
WHERE availability_365 IS NULL;

UPDATE rental
SET house_rules = 'unspecified'
WHERE house_rules IS NULL;


Select * FROM rental
WHERE NAME = 'BlissArtsSpace!'