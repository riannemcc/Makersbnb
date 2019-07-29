ALTER TABLE properties RENAME COLUMN owner_name TO owner_id;
ALTER TABLE properties ALTER COLUMN owner_id SET DATA TYPE INTEGER USING owner_id::integer;
