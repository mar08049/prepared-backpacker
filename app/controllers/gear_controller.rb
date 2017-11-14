require 'pry'

class GearController < ApplicationController

  get '/gear' do
    if logged_in?
      @gears = current_user.gears
      erb :'/gear/index'
    else
      redirect '/'
    end
  end

  get '/gear/new' do
    if logged_in?
      erb :'/gear/new'
    else
      redirect '/login'
    end
  end

  post '/gear' do
    if logged_in?
      if !params[:name].empty?
        @gear = current_user.gears.build(name: params[:name])
        if @gear.save
          redirect "/users/#{current_user.slug}"
        end
      end
      redirect '/gear/new'
    else
      redirect to '/login'
    end
  end

  get '/gear/:id' do
    if logged_in?
      @gear = Gear.find_by(id: params[:id])
      if @gear && @gear.user == current_user
        erb :'/gear/show'
      else
        redirect "/users/#{current_user.slug}"
      end
    else
      redirect '/'
    end
  end

  get '/gear/:id/edit' do
    if logged_in?
      @gear = Gear.find_by_id(params[:id])
      if @gear && @gear.user == current_user
      erb :'/gear/show'
      end
    else
      redirect '/login'
    end
  end

  patch '/gear/:id' do
    if logged_in?
      @gear = Gear.find_by_id(params[:id])
      if @gear.user == current_user && !params[:name].empty?
        @gear.update(name: params[:name])
        redirect "/gear/#{@gear.id}"
      else
        redirect "/users/#{current_user.slug}"
      end
    else
      redirect '/login'
    end
  end

  delete '/gear/:id' do
    @gear = Gear.find_by(id: params[:id])
    if logged_in?
      if @gear && @gear.user == current_user
        @gear.destroy
        redirect "/users/#{current_user.slug}"
      else
        redirect '/gear/#{@gear.id}'
      end
    else
      redirect '/login'
    end
  end
end
