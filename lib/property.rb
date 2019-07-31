
class Property

  attr_reader :id, :name, :description, :price

  def initialize(id, name, description, price)
    @id = id
    @name = name
    @description = description
    @price = price
    @available = true
  end

  def available?
    true
  end


end
