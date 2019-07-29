
class Property

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
