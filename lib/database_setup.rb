require_relative 'database'

if ENV['RACK_ENV'] == 'test'
  @connection = Database.setup("makersbnb_test")
else
  @connection = Database.setup("makersbnb")
end
