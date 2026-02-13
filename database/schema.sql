-- PostgreSQL DDL for SmartHotel Database

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES role(id)
);

CREATE TABLE hotel (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address TEXT NOT NULL,
    rating DECIMAL(2, 1)
);

CREATE TABLE room (
    id SERIAL PRIMARY KEY,
    hotel_id INTEGER REFERENCES hotel(id),
    room_number VARCHAR(20) NOT NULL,
    type VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE amenity (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE hotel_amenity (
    hotel_id INTEGER REFERENCES hotel(id),
    amenity_id INTEGER REFERENCES amenity(id),
    PRIMARY KEY (hotel_id, amenity_id)
);

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    hotel_id INTEGER REFERENCES hotel(id),
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50)
);

CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES "user"(id),
    room_id INTEGER REFERENCES room(id),
    check_in TIMESTAMP NOT NULL,
    check_out TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE service (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE booking_service (
    booking_id INTEGER REFERENCES booking(id),
    service_id INTEGER REFERENCES service(id),
    PRIMARY KEY (booking_id, service_id)
);

CREATE TABLE tourist_place (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES booking(id),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);

CREATE TABLE maintenance_request (
    id SERIAL PRIMARY KEY,
    room_id INTEGER REFERENCES room(id),
    description TEXT,
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cleaning_log (
    id SERIAL PRIMARY KEY,
    room_id INTEGER REFERENCES room(id),
    cleaned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    staff_id INTEGER REFERENCES staff(id)
);


-- Seed Data
INSERT INTO role (name) VALUES
('Admin'),
('User');

INSERT INTO hotel (name, address, rating) VALUES
('Grand Hotel', '1234 Elm St, Springfield', 4.5),
('Cozy Inn', '5678 Oak St, Springfield', 4.0);

INSERT INTO amenity (name) VALUES
('WiFi'),
('Swimming Pool'),
('Gym'),
('Parking');

INSERT INTO room (hotel_id, room_number, type, price, is_available) VALUES
(1, '101', 'Single', 100.00, TRUE),
(1, '102', 'Double', 150.00, TRUE),
(2, '201', 'Suite', 200.00, TRUE);

INSERT INTO service (name, price) VALUES
('Room Service', 20.00),
('Laundry', 15.00),
('Spa', 50.00);

INSERT INTO tourist_place (name, description) VALUES
('Museum of Natural History', 'A large museum with various exhibits.'),
('City Park', 'A beautiful park with walking trails.');