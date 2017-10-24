class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'/users/signup'
    else
      @user = current_user
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
  end

  post '/signup' do
    if params["username"] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.slug}"
    else
      erb :'/users/signup'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'/users/login'
    else
      @user = current_user
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.slug}"
      else
        redirect '/login'
      end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user = current_user
    if current_user
       erb :'/users/show'
     else
       redirect '/gear'
     end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
