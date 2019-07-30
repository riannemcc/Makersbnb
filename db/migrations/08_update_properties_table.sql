ALTER TABLE properties ADD FOREIGN KEY (owner_id) REFERENCES users (id);
