ALTER TABLE bookings ADD COLUMN owner_id INTEGER;
ALTER TABLE bookings ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES users (id);
