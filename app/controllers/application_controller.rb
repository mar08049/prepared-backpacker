require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
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
    def current_user
       User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
