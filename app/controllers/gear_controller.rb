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

  get '/gear/:id' do
    if logged_in?
      @user = current_user
      @gear = Gear.find_by(id: params[:id])
      @user.gears << @gear

      erb :'gear/show'
    else
      redirect '/'
    end
  end

  get '/gear/:id/edit' do
    @gear = Gear.find_by(id: params[:id])
      erb :'gear/edit'
  end

  patch '/gear/:id' do
    if logged_in? && !params[:name].empty?
      @gear = Gear.find_by(id: params[:id])
      @gear.name = (params[:name])
      @gear.save
      redirect "/gear/#{@gear.id}"
    else
      redirect "/gear/#{params[:id]}/edit"
    end
  end

  delete '/gear/:id/delete' do
    @gear = Gear.find_by(id: params[:id])
    @user = current_user
    if logged_in? && @gear.user == current_user
      @gear.delete
      redirect '/gear'
    else
      redirect "/gear/#{@gear.id}"
    end
  end
end
