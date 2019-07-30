require_relative 'property'
require_relative 'user'
require_relative 'database'

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

end
