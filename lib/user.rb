require_relative 'database'
require 'bcrypt'

class User

  attr_reader :name, :email, :password

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def self.create(name:, email:, password:)
    result = Database.query("SELECT * FROM users WHERE email_address='#{email}';")
    return -1 unless !result.any?
    encrypted_pass = BCrypt::Password.create(password)
    result = Database.query("INSERT INTO users (name, email_address, password) VALUES('#{name}', '#{email}', '#{encrypted_pass}') RETURNING id;")
    result[0]['id']
  end

  def self.authenticate(email:, password:)
    result = Database.query("SELECT * FROM users WHERE email_address='#{email}';")
    return -1 unless result.any?
    unencrypted_pass = BCrypt::Password.new(result[0]['password'])
    return -1 if (unencrypted_pass != password)
    result[0]['id']
  end
end
