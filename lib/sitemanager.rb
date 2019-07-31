require_relative 'property'
require_relative 'user'
require_relative 'database'
require 'date'

class SiteManager

  # def initialize(dbname)
  #   Database.setup(dbname)
  # end

  def self.add_listings(owner_id:, name:, description:, price:)
    Database.query("INSERT INTO properties (owner_id, property_name, description, price) VALUES('#{owner_id}','#{name}', '#{description}', '#{price}');")
  end

  def self.get_available_listings
    properties = Database.query("SELECT * FROM properties;")
    properties.map { |property|
      Property.new(
        property['id'],
        property['property_name'],
        property['description'],
        property['price']
      )
    }
  end

  def self.add_booking_request(renter_id:, property_id:, start_date:, end_date:)
    pending = 'pending'
    startdate = Date.strptime(start_date,'%Y-%m-%d')
    enddate = Date.strptime(end_date,'%Y-%m-%d')
    p owner_id = Database.query("SELECT owner_id FROM properties WHERE id = '#{property_id}';").first['owner_id']
    Database.query("INSERT INTO bookings (approved, owner_id, renter_id, property_id, start_date, end_date) VALUES('#{pending}', '#{owner_id}', '#{renter_id}', '#{property_id}', '#{startdate}', '#{enddate}');")
  end

  def self.get_renter_booking_requests(id:)
    Database.query("SELECT properties.property_name, to_char(bookings.start_date::timestamp, 'DD-MM-YYYY') AS start_date, to_char(bookings.end_date::timestamp, 'DD-MM-YYYY') AS end_date, bookings.approved FROM bookings
    INNER JOIN properties
    ON bookings.property_id = properties.id
    WHERE renter_id = '#{id}';")
  end

  def self.get_owner_booking_requests(id:)
    Database.query("SELECT properties.property_name, to_char(bookings.start_date::timestamp, 'DD-MM-YYYY') AS start_date, to_char(bookings.end_date::timestamp, 'DD-MM-YYYY') AS end_date, bookings.approved FROM bookings
      INNER JOIN properties
      ON bookings.property_id = properties.id
      WHERE bookings.owner_id = '#{id}';")
  end
end
