require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'rack-flash'
require_relative './lib/sitemanager.rb'
require_relative './lib/database_setup'


class Makersbnb < Sinatra::Base
register Sinatra::Flash
helpers Sinatra::RedirectWithFlash

  get '/' do
    @properties = SiteManager.get_available_listings
    erb :index
  end

  get '/list_property' do
    erb :list_property
  end

  post '/list_property' do
    SiteManager.add_listings(name: params[:name], description: params[:description], price: params[:price])
    redirect '/'
  end

  get '/book_property/:name' do
    erb :book_property
  end

  post '/book_property/:name' do
    
    redirect '/', notice: 'Booking request submitted!'
  end
end
