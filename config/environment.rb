require 'bundler/setup'
Bundler.require

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/Makersbnb')
end
