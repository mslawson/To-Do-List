class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to todo_lists_path
  		flash[:success] = "Thanks for logging in!"
  	else
  		flash[:error] = "Sorry you must be a registered user."
  		render action: 'new'
  	end
  end
end
