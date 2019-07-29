require 'sinatra/base'
require_relative './lib/sitemanager.rb'
require_relative './lib/database_setup'

class Makersbnb < Sinatra::Base

  get '/' do
    @properties = SiteManager.get_available_listings
    erb :index
  end

  get '/list_property' do
    erb :list_property
  end

  post '/list_property' do
    p params[:name]
    SiteManager.add_listings(name: params[:name], description: params[:description], price: params[:price])
    redirect '/'
  end

end
