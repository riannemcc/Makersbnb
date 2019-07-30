require_relative 'database'

class User

  attr_reader :name, :email, :password

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def self.create(name:, email:, password:)
    result = Database.query("INSERT INTO users (name, email_address, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING id;")
    result[0]['id']
  end
end
