
class Property

  attr_reader :id, :name, :description, :price, :image

  def initialize(id, name, description, price, image)
    @id = id
    @name = name
    @description = description
    @price = price
    @available = true
    @image = image
  end

  def available?
    true
  end


end
