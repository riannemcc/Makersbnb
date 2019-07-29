require_relative 'property'
require_relative 'user'
require_relative 'database'

class SiteManager

  def initialize
    Database.setup('makersbnb')
  end

  def self.get_available_listings
    properties = Database.query('')
    properties.map { |property|
      Property.new(
        property['name'],
        property['description'],
        property['price']
      )
    }
  end

end
