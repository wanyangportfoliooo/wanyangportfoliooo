-- Depop Second-hand Fashion Marketplace
-- PostgreSQL
--
-- This database models an online marketplace for buying and selling
-- second-hand fashion items in Australia.

-- =====================================================
-- DROP EXISTING OBJECTS
-- =====================================================

DROP VIEW IF EXISTS vw_user_transaction_summary;
DROP VIEW IF EXISTS vw_listing_details;
DROP TABLE IF EXISTS SHIPMENT CASCADE;
DROP TABLE IF EXISTS "TRANSACTION" CASCADE;
DROP TABLE IF EXISTS LISTING_CATEGORY CASCADE;
DROP TABLE IF EXISTS FOLLOW CASCADE;
DROP TABLE IF EXISTS LISTING CASCADE;
DROP TABLE IF EXISTS CATEGORY CASCADE;
DROP TABLE IF EXISTS BRAND CASCADE;
DROP TABLE IF EXISTS "USER" CASCADE;

-- =====================================================
-- CREATE TABLES
-- =====================================================

CREATE TABLE "USER" (
    user_id SERIAL,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_user PRIMARY KEY (user_id),
    CONSTRAINT chk_user_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_user_phone CHECK (phone ~ '^\+?[0-9 \-]{7,20}$'),
    CONSTRAINT chk_user_join_date CHECK (join_date <= CURRENT_DATE)
);

CREATE TABLE BRAND (
    brand_id SERIAL,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    country_of_origin VARCHAR(100),
    CONSTRAINT pk_brand PRIMARY KEY (brand_id)
);

CREATE TABLE CATEGORY (
    category_id SERIAL,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_category PRIMARY KEY (category_id)
);

CREATE TABLE LISTING (
    listing_id SERIAL,
    user_id INTEGER NOT NULL,
    brand_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    price NUMERIC(10,2) NOT NULL,
    condition VARCHAR(20) NOT NULL,
    size VARCHAR(10),
    listed_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_listing PRIMARY KEY (listing_id),
    CONSTRAINT fk_listing_user
        FOREIGN KEY (user_id)
        REFERENCES "USER" (user_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_listing_brand
        FOREIGN KEY (brand_id)
        REFERENCES BRAND (brand_id)
        ON DELETE RESTRICT,
    CONSTRAINT chk_listing_price CHECK (price > 0),
    CONSTRAINT chk_listing_condition
        CHECK (condition IN ('New', 'Like New', 'Good', 'Fair', 'Poor')),
    CONSTRAINT chk_listing_size
        CHECK (size IN ('XS', 'S', 'M', 'L', 'XL', 'XXL', 'One Size')),
    CONSTRAINT chk_listing_date CHECK (listed_date <= CURRENT_DATE)
);

CREATE TABLE LISTING_CATEGORY (
    listing_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    CONSTRAINT pk_listing_category PRIMARY KEY (listing_id, category_id),
    CONSTRAINT fk_lc_listing
        FOREIGN KEY (listing_id)
        REFERENCES LISTING (listing_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_lc_category
        FOREIGN KEY (category_id)
        REFERENCES CATEGORY (category_id)
        ON DELETE RESTRICT
);

CREATE TABLE "TRANSACTION" (
    transaction_id SERIAL,
    listing_id INTEGER NOT NULL UNIQUE,
    user_id INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    platform_fee NUMERIC(10,2) NOT NULL,
    transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    user_rating INTEGER,
    user_comment VARCHAR(500),
    CONSTRAINT pk_transaction PRIMARY KEY (transaction_id),
    CONSTRAINT fk_transaction_listing
        FOREIGN KEY (listing_id)
        REFERENCES LISTING (listing_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_transaction_user
        FOREIGN KEY (user_id)
        REFERENCES "USER" (user_id)
        ON DELETE RESTRICT,
    CONSTRAINT chk_transaction_amount CHECK (amount > 0),
    CONSTRAINT chk_transaction_fee CHECK (platform_fee >= 0),
    CONSTRAINT chk_transaction_status
        CHECK (status IN ('Pending', 'Completed', 'Cancelled', 'Refunded')),
    CONSTRAINT chk_transaction_rating
        CHECK (user_rating IS NULL OR user_rating BETWEEN 1 AND 5),
    CONSTRAINT chk_transaction_date CHECK (transaction_date <= CURRENT_DATE)
);

CREATE TABLE SHIPMENT (
    shipment_id SERIAL,
    transaction_id INTEGER NOT NULL UNIQUE,
    tracking_number VARCHAR(50) NOT NULL UNIQUE,
    carrier VARCHAR(50) NOT NULL,
    shipped_date DATE,
    estimated_delivery DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'Processing',
    CONSTRAINT pk_shipment PRIMARY KEY (shipment_id),
    CONSTRAINT fk_shipment_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES "TRANSACTION" (transaction_id)
        ON DELETE RESTRICT,
    CONSTRAINT chk_shipment_status
        CHECK (status IN ('Processing', 'Shipped', 'In Transit', 'Delivered', 'Returned')),
    CONSTRAINT chk_shipment_carrier
        CHECK (carrier IN ('Australia Post', 'StarTrack', 'Sendle', 'DHL', 'FedEx'))
);

CREATE TABLE FOLLOW (
    follower_id INTEGER NOT NULL,
    followed_id INTEGER NOT NULL,
    CONSTRAINT pk_follow PRIMARY KEY (follower_id, followed_id),
    CONSTRAINT fk_follow_follower
        FOREIGN KEY (follower_id)
        REFERENCES "USER" (user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_follow_followed
        FOREIGN KEY (followed_id)
        REFERENCES "USER" (user_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_follow_no_self CHECK (follower_id <> followed_id)
);

-- =====================================================
-- CREATE VIEWS
-- =====================================================

-- Full listing details with brand, seller, and category information.
CREATE VIEW vw_listing_details AS
SELECT
    l.listing_id,
    l.title,
    l.price,
    l.condition,
    l.size,
    l.listed_date,
    b.brand_name,
    u.user_name AS seller_name,
    c.category_name
FROM LISTING AS l
JOIN BRAND AS b
    ON l.brand_id = b.brand_id
JOIN "USER" AS u
    ON l.user_id = u.user_id
JOIN LISTING_CATEGORY AS lc
    ON l.listing_id = lc.listing_id
JOIN CATEGORY AS c
    ON lc.category_id = c.category_id;

-- Purchase count, spending, and average rating for each user.
CREATE VIEW vw_user_transaction_summary AS
SELECT
    u.user_id,
    u.user_name,
    COUNT(t.transaction_id) AS total_purchases,
    COALESCE(SUM(t.amount), 0) AS total_spent,
    COALESCE(AVG(t.user_rating), 0) AS avg_rating_given
FROM "USER" AS u
LEFT JOIN "TRANSACTION" AS t
    ON u.user_id = t.user_id
GROUP BY
    u.user_id,
    u.user_name;

-- =====================================================
-- INSERT SAMPLE DATA
-- =====================================================

INSERT INTO "USER" (user_name, email, phone, join_date) VALUES
    ('alice_styles', 'alice@email.com', '+61 412 111 111', '2023-01-15'),
    ('bob_vintage', 'bob@email.com', '+61 423 222 222', '2023-03-20'),
    ('carol_thrift', 'carol@email.com', '+61 434 333 333', '2023-06-10'),
    ('david_resell', 'david@email.com', '+61 445 444 444', '2024-01-05'),
    ('emma_fashion', 'emma@email.com', '+61 456 555 555', '2024-02-14'),
    ('frank_buyer', 'frank@email.com', '+61 467 666 666', '2024-03-01');

INSERT INTO BRAND (brand_name, country_of_origin) VALUES
    ('Nike', 'United States'),
    ('Levi''s', 'United States'),
    ('Zara', 'Spain'),
    ('Adidas', 'Germany'),
    ('Vintage No Brand', 'Australia');

INSERT INTO CATEGORY (category_name) VALUES
    ('Tops'),
    ('Jeans'),
    ('Shoes'),
    ('Accessories'),
    ('Dresses');

INSERT INTO LISTING (
    user_id,
    brand_id,
    title,
    description,
    price,
    condition,
    size,
    listed_date
) VALUES
    (1, 1, 'Nike Air Force 1 White', 'Classic white sneakers, worn twice, great condition.', 85.00, 'Like New', 'M', '2024-03-01'),
    (1, 2, 'Levi''s 501 Jeans Blue', 'Iconic straight leg jeans, perfect vintage wash.', 65.00, 'Good', 'M', '2024-03-05'),
    (2, 1, 'Nike Hoodie Black', 'Warm and comfy, only worn a few times.', 55.00, 'Good', 'L', '2024-03-10'),
    (2, 3, 'Zara Floral Dress', 'Beautiful summer dress, worn once to a party.', 45.00, 'Like New', 'S', '2024-03-15'),
    (3, 4, 'Adidas Track Pants', 'Classic 3-stripe track pants, great for gym.', 40.00, 'Good', 'L', '2024-04-01'),
    (3, 2, 'Levi''s Denim Jacket', 'Vintage denim jacket, amazing condition.', 90.00, 'Like New', 'M', '2024-04-05'),
    (4, 5, 'Vintage Band Tee', 'Rare 90s band tee, some fading adds to the charm.', 35.00, 'Fair', 'S', '2024-04-10'),
    (4, 3, 'Zara Blazer Cream', 'Elegant cream blazer, never worn, still has tags.', 75.00, 'New', 'M', '2024-04-15');

INSERT INTO LISTING_CATEGORY (listing_id, category_id) VALUES
    (1, 3),
    (2, 2),
    (3, 1),
    (4, 5),
    (4, 4),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1);

INSERT INTO "TRANSACTION" (
    listing_id,
    user_id,
    amount,
    platform_fee,
    transaction_date,
    status,
    user_rating,
    user_comment
) VALUES
    (1, 5, 85.00, 8.50, '2024-03-10', 'Completed', 5, 'Perfect condition, fast shipping!'),
    (2, 6, 65.00, 6.50, '2024-03-12', 'Completed', 4, 'Great jeans, as described.'),
    (3, 5, 55.00, 5.50, '2024-03-20', 'Completed', 5, 'Love the hoodie, seller was great.'),
    (4, 6, 45.00, 4.50, '2024-03-25', 'Completed', 3, 'Dress was slightly different colour.'),
    (5, 1, 40.00, 4.00, '2024-04-05', 'Completed', 5, 'Amazing track pants, very fast delivery.'),
    (6, 2, 90.00, 9.00, '2024-04-10', 'Completed', NULL, NULL),
    (7, 3, 35.00, 3.50, '2024-04-15', 'Pending', NULL, NULL);

INSERT INTO SHIPMENT (
    transaction_id,
    tracking_number,
    carrier,
    shipped_date,
    estimated_delivery,
    status
) VALUES
    (1, 'AP-2024-001001', 'Australia Post', '2024-03-11', '2024-03-14', 'Delivered'),
    (2, 'AP-2024-001002', 'Australia Post', '2024-03-13', '2024-03-16', 'Delivered'),
    (3, 'SN-2024-003003', 'Sendle', '2024-03-21', '2024-03-24', 'Delivered'),
    (4, 'AP-2024-001004', 'Australia Post', '2024-03-26', '2024-03-29', 'Delivered'),
    (5, 'ST-2024-005005', 'StarTrack', '2024-04-06', '2024-04-08', 'Delivered'),
    (6, 'AP-2024-001006', 'Australia Post', '2024-04-11', '2024-04-14', 'In Transit');

INSERT INTO FOLLOW (follower_id, followed_id) VALUES
    (1, 2),
    (1, 3),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 2),
    (6, 3);

-- =====================================================
-- EXAMPLE QUERIES
-- =====================================================

-- 1. Listings priced over $50, ordered by price.
SELECT
    listing_id,
    title,
    price,
    condition,
    size
FROM LISTING
WHERE price > 50
ORDER BY price DESC;

-- 2. Transactions with buyer names.
SELECT
    t.transaction_id,
    u.user_name AS buyer_name,
    t.amount,
    t.status,
    t.transaction_date
FROM "TRANSACTION" AS t
JOIN "USER" AS u
    ON t.user_id = u.user_id
ORDER BY t.transaction_id;

-- 3. Listing count and average price by brand.
SELECT
    b.brand_name,
    COUNT(l.listing_id) AS total_listings,
    ROUND(AVG(l.price), 2) AS avg_price
FROM BRAND AS b
JOIN LISTING AS l
    ON b.brand_id = l.brand_id
GROUP BY
    b.brand_id,
    b.brand_name
HAVING COUNT(l.listing_id) > 1
ORDER BY total_listings DESC;

-- 4. Listings that have never been purchased.
SELECT
    l.listing_id,
    l.title,
    l.price,
    l.condition
FROM LISTING AS l
WHERE NOT EXISTS (
    SELECT 1
    FROM "TRANSACTION" AS t
    WHERE t.listing_id = l.listing_id
)
ORDER BY l.listing_id;

-- 5. Pairs of users who follow each other.
SELECT
    u1.user_name AS user_1,
    u2.user_name AS user_2
FROM FOLLOW AS f1
JOIN FOLLOW AS f2
    ON f1.follower_id = f2.followed_id
    AND f1.followed_id = f2.follower_id
JOIN "USER" AS u1
    ON u1.user_id = f1.follower_id
JOIN "USER" AS u2
    ON u2.user_id = f1.followed_id
WHERE f1.follower_id < f1.followed_id
ORDER BY u1.user_name;
