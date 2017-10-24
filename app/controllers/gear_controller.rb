class GearController < ApplicationController

  get '/gear' do
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      erb :'/gear/home'
    else
      redirect '/'
    end
  end

  get '/candies/new' do
    @gear = Gear.find_by(id: params[:id])
    if logged_in? && current_user
      @gear = current_user
      session[:user_id] = @user.id
      erb :'/gear/new'
    else
      redirect '/'
    end
  end

  post '/gear' do
    @user = current_user
    if logged_in? && !params[:name].empty?
    @gear = Gear.create(name: params[:name])
    redirect '/gear'
    else
      redirect '/gear/new'
    end
  end

  get '/gear/:id' do
    if logged_in?
      @user = current_user
      @gear = Gear.find_by(id: params[:id])
      erb :'gear/show'
    else
      redirect '/'
    end
  end

  get '/gear/:id/edit' do
    if logged_in?
      @gear = Gear.find_by(id: params[:id])
      erb :'gear/edit'
    else
      flash[:notice] = "You're not logged in"
      redirect '/'
    end
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

  delete '/candies/:id/edit' do
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
