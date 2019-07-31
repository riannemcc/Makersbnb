require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'rack-flash'
require_relative './lib/sitemanager.rb'
require_relative './lib/database_setup'


class Makersbnb < Sinatra::Base
register Sinatra::Flash
helpers Sinatra::RedirectWithFlash
enable :sessions

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

  post '/book_page_request' do
    session['property_id'] = params[:property_id]
    redirect "/book_property"
  end

  get '/book_property' do
    erb :book_property
  end

  post '/book_property' do
    SiteManager.add_booking_request(property_id: session['property_id'], start_date: params[:start_date], end_date: params[:end_date])
    redirect '/', notice: 'Booking request submitted!'
  end
end
