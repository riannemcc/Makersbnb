require 'sinatra/base'
require_relative './lib/sitemanager.rb'

class Makersbnb < Sinatra::Base

  get '/' do
    @properties = SiteManager.get_available_listings
    erb :index
  end

  get '/list_property' do
    erb :list_property
  end

  post '/list_property' do
    Property.new(params[:name], params[:description], params[:price])
    redirect '/'
  end
end
