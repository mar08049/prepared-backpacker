require 'pry'

class GearController < ApplicationController

  get '/gear' do
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id

      @gears = []
      erb :'/gear/index'
    else
      redirect '/'
    end
  end

  get '/gear/new' do
    @gear = Gear.find_by(id: params[:id])
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      erb :'/gear/new'
    else
      redirect '/'
    end
  end

  post '/gear' do
    @user = current_user
    if logged_in? && !params[:name].empty?
      @user.gears.create(name: params[:name])
    redirect '/gear'
    else
      redirect '/gear/new'
    end
  end

  


end
