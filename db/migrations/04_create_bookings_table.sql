CREATE TABLE bookings(id SERIAL PRIMARY KEY, property_id INTEGER REFERENCES properties (id), renter_id INTEGER REFERENCES users (id), start_date DATE, end_date DATE);
