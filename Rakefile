require 'pg'

task :test_database_setup do
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE properties, users, bookings;")
end

task :setup do
  p "Creating databases..."

  ['makersbnb', 'makersbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")

    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE properties(id SERIAL PRIMARY KEY, property_name VARCHAR(60), description VARCHAR, price NUMERIC, owner_name VARCHAR);")
    connection.exec("CREATE TABLE users(id SERIAL PRIMARY KEY, name VARCHAR(60));")
    connection.exec("CREATE TABLE bookings(id SERIAL PRIMARY KEY, property_id INTEGER REFERENCES properties (id), renter_id INTEGER REFERENCES users (id), start_date DATE, end_date DATE);")
    connection.exec("ALTER TABLE users ADD COLUMN email_address VARCHAR;")
    connection.exec("ALTER TABLE users ADD COLUMN password VARCHAR;")
    connection.exec("ALTER TABLE properties RENAME COLUMN owner_name TO owner_id;")
    connection.exec("ALTER TABLE properties ALTER COLUMN owner_id SET DATA TYPE INTEGER USING owner_id::integer;")
    connection.exec("ALTER TABLE properties ADD FOREIGN KEY (owner_id) REFERENCES users (id);")
    connection.exec("ALTER TABLE bookings ADD COLUMN approved VARCHAR;")
    connection.exec("ALTER TABLE bookings ADD COLUMN owner_id INTEGER;")
    connection.exec("ALTER TABLE bookings ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES users (id);")
    connection.exec("ALTER TABLE properties ADD COLUMN image VARCHAR;")
    connection.exec("ALTER TABLE properties ADD COLUMN location VARCHAR;")
  end
end

task :teardown do
  p "Destroying databases...type 'y' to confirm that you want to destroy the Bookmark Manager databases. This will remove all data in those databases!"

  confirm = STDIN.gets.chomp

  return unless confirm == 'y'

  ['makersbnb', 'makersbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{ database }")
  end
end
