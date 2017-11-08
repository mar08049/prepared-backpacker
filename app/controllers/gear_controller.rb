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
      redirect '/gear/show'
    else
      redirect '/gear/new'
    end
  end

  get '/gear/:id' do
    @gear = Gear.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'/gear/show'
    else
      redirect '/login'
    end
  end

  get '/gear/:id/edit' do
    if logged_in? && @gear.user == current_user
      erb :'/gear/edit'
    else
      redirect '/login'
    end
  end

  patch '/gear/:id' do
    @gear = Gear.find_by_id(params[:id])
    if logged_in? && @gear.user == current_user && !params[:name].empty?
      @user = current_user
      @gear.update(name: params[:name])
      @gear.save
      redirect "/gear/#{@gear.id}"
    else
      redirect "/gear/#{@gear.id}/edit"
    end
  end
  delete '/gear/:id/edit' do
    @gear = Gear.find_by(id: params[:id])
    @user = current_user
    if logged_in?
      @gear.delete
      redirect '/gear'
    else
      redirect "/gear/#{@gear.id}"
    end
  end



end

  # To do.......
  # looking into the _method Rack:method overide
  # Have CRUD for the belongs to resource
  # Read up more session
    # https://learn.co/tracks/full-stack-web-development-v3/sinatra/sessions/sessions-and-cookies 
    # https://learn.co/tracks/full-stack-web-development-v3/sinatra/sessions/mechanics-of-sessions 
  # Link for project 1:1s
    # http://bit.ly/portfolio-project-support 
  # 1-2 (available in the next 24 hours)
