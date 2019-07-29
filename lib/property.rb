
class Property

  attr_reader :name, :description, :price

  def initialize(name, description, price)
    @name = name
    @description = description
    @price = price
    @available = true
  end

  def available?
    true
  end


end
