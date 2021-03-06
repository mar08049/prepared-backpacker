require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'backpackers'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  delete 'gear/:id/delete' do
    @gear = Gear.find_by(id: params[:id])
    @gear.delete
    redirect to '/gear'
  end

  helpers do
    def current_user #=> returns User instance || nil
       User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end

end
