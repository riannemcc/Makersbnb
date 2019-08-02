
class Property

  attr_reader :id, :name, :description, :price, :image, :location, :weather

  def initialize(id, name, description, price, image, location, weather)
    @id = id
    @name = name
    @description = description
    @price = price
    @image = image
    @location = location
    @weather = weather
  end

end
