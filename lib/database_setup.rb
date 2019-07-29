require_relative 'database'

if ENV['ENVIRONMENT'] == 'test'
  @connection = Database.setup("makersbnb_test")
else
  @connection = Database.setup("makersbnb")
end
