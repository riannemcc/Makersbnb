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
    owner_id = Database.query("SELECT owner_id FROM properties WHERE id = '#{property_id}';").first['owner_id']
    Database.query("INSERT INTO bookings (approved, owner_id, renter_id, property_id, start_date, end_date) VALUES('#{pending}', '#{owner_id}', '#{renter_id}', '#{property_id}', '#{startdate}', '#{enddate}');")
  end

  def self.get_renter_booking_requests(id:)
    Database.query("SELECT properties.id, properties.property_name, to_char(bookings.start_date::timestamp, 'DD-MM-YYYY') AS start_date, to_char(bookings.end_date::timestamp, 'DD-MM-YYYY') AS end_date, bookings.approved FROM bookings
    INNER JOIN properties
    ON bookings.property_id = properties.id
    WHERE renter_id = '#{id}';")
  end

  def self.get_owner_booking_requests(id:, request_id: '')
    request_filter = request_id == '' ? '' : " AND bookings.id = '#{request_id}'"
    p "#{id} #{request_filter}"
      Database.query("SELECT users.name, users.email_address, bookings.id AS booking_id, properties.id AS property_id, properties.property_name, to_char(bookings.start_date::timestamp, 'DD-MM-YYYY') AS start_date, to_char(bookings.end_date::timestamp, 'DD-MM-YYYY') AS end_date, bookings.approved FROM bookings
      INNER JOIN users
      ON bookings.renter_id = users.id
      INNER JOIN properties
      ON bookings.property_id = properties.id
      WHERE bookings.owner_id = '#{id}'#{request_filter};")
  end

  def self.get_property_booking_requests(id:, property_id:)
    Database.query("SELECT users.name, users.email_address, properties.id, properties.property_name, to_char(bookings.start_date::timestamp, 'DD-MM-YYYY') AS start_date, to_char(bookings.end_date::timestamp, 'DD-MM-YYYY') AS end_date, bookings.approved FROM bookings
      INNER JOIN users
      ON bookings.renter_id = users.id
      INNER JOIN properties
      ON bookings.property_id = properties.id
      WHERE bookings.owner_id = '#{id}' AND bookings.property_id = '#{property_id}';")
  end

  def self.update_approval_status(request_id:, response:)
    response = response == "Reject" ? "Rejected" : response
    request_range = Database.query("UPDATE bookings SET approved = '#{response}' WHERE id = '#{request_id}' RETURNING #{tstzrange(start_date,end_date,'[)')};").first
    return if response == "Rejected"
   Database.query("UPDATE bookings SET approved = 'Rejected' WHERE (start_date, end_date) OVERLAPS #{request_range}")
  end
end
