require 'sitemanager'
require 'property'

describe SiteManager do

  describe '.get_available_listings' do
    it 'returns a list of properties' do

      Database.query("INSERT INTO properties (property_name, description, price) VALUES('Hello', 'Haha', '1000');")

      site_manager = SiteManager.get_available_listings

      expect(site_manager.length).to eq 1
      expect(site_manager.first).to be_a Property
      expect(site_manager.first.name).to eq 'Hello'
      expect(site_manager.first.description).to eq 'Haha'
      expect(site_manager.first.price).to eq '1000'
    end
  end

  describe '.add_listings' do
    it 'add properties to a list' do
      bob = Database.query("INSERT INTO users (name, email_address, password) VALUES('Hello', 'haha@haha.com', 'abc') RETURNING id;").first
      site_manager = SiteManager.add_listings(owner_id: bob['id'], name: "Hello", description: "Haha", price: "1000", image: '')

      properties = Database.query("SELECT * FROM properties;")

      expect(properties.first["property_name"]).to eq 'Hello'
      expect(properties.first["description"]).to eq 'Haha'
      expect(properties.first["price"]).to eq '1000'
    end
  end

  describe '.add_bookings' do
    it 'adds bookings to the database' do
      bob = Database.query("INSERT INTO users (name, email_address, password) VALUES('Hello', 'haha@haha.com', 'abc') RETURNING id;").first
      property_id = SiteManager.add_listings(owner_id: bob['id'], name: "Hello", description: "Haha", price: "1000", image: '')
      site_manager = SiteManager.add_booking_request(renter_id: bob['id'], property_id: property_id.first['id'], start_date: "08-01-2019", end_date: "08-29-2019")

      bookings = Database.query("SELECT * FROM bookings;")

      expect(bookings.first["start_date"]).to eq '2019-08-01'
      expect(bookings.first["end_date"]).to eq '2019-08-29'
    end
  end

  describe '.get_property_booking_requests' do
    it 'returns booking requests for property' do
      bob = Database.query("INSERT INTO users (name, email_address, password) VALUES('Hello', 'haha@haha.com', 'abc') RETURNING id;").first
      property_id = SiteManager.add_listings(owner_id: bob['id'], name: "Hello", description: "Haha", price: "1000", image: '')
      site_manager = SiteManager.add_booking_request(renter_id: bob['id'], property_id: property_id.first['id'], start_date: "08-01-2019", end_date: "08-29-2019")

      bookings = SiteManager.get_property_booking_requests(id: bob['id'], property_id: property_id.first['id'])

      expect(bookings.first["start_date"]).to eq '01-08-2019'
      expect(bookings.first["end_date"]).to eq '29-08-2019'
    end
  end

  describe '.update_approval_status' do
    it 'returns confirmed for approved properties' do
    bob = Database.query("INSERT INTO users (name, email_address, password) VALUES('Hello', 'haha@haha.com', 'abc') RETURNING id;").first
    property_id = Database.query("INSERT INTO properties (owner_id, property_name, description, price) VALUES(#{bob['id']}, 'Hello', 'Haha', '1000') RETURNING id;").first
    booked = Database.query("INSERT INTO bookings (approved, owner_id, renter_id, property_id, start_date, end_date) VALUES('pending', #{bob['id']}, #{bob['id']}, #{property_id['id']}, '08-01-2019', '08-29-2019') RETURNING id;").first
      SiteManager.update_approval_status(request_id: booked['id'], response: 'Confirm')
      booking = Database.query("SELECT * FROM bookings WHERE id = '#{booked['id']}';").first

      expect(booking['approved']).to eq 'Confirmed'

    end
  end
end
