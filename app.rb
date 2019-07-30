require 'sinatra/base'
require_relative './lib/sitemanager.rb'
require_relative './lib/database_setup'
require_relative './lib/user.rb'

class Makersbnb < Sinatra::Base

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    if params[:password] != params[:password_confirmation]
      redirect '/sign_up'
    end

    id = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect '/index'
  end

  get '/index' do
    @properties = SiteManager.get_available_listings
    erb :index
  end

  get '/list_property' do
    erb :list_property
  end

  post '/list_property' do
    SiteManager.add_listings(name: params[:name], description: params[:description], price: params[:price])
    redirect '/index'
  end

end
