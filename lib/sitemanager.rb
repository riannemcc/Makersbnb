require_relative 'property'
require_relative 'user'
require_relative 'database'
require 'date'

class SiteManager

  # def initialize(dbname)
  #   Database.setup(dbname)
  # end

  def self.add_listings(name:, description:, price:)
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('#{name}', '#{description}', '#{price}');")
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

  def self.add_booking_request(property_id:, start_date:, end_date:)
    startdate = Date.strptime(start_date,'%Y-%m-%d')
    enddate = Date.strptime(end_date,'%Y-%m-%d')
    Database.query("INSERT INTO bookings (property_id, start_date, end_date) VALUES('#{property_id}', '#{startdate}', '#{enddate}');")
  end

end
