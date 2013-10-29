class SessionsController < ApplicationController
    skip_before_filter :authorize, only: [:new, :create]

def new
	@instructor = Instructor.new
end


def create
     instructor = Instructor.find_by_username(params[:instructor][:username])
     if instructor == nil
          redirect_to new_session_path, :flash => { :error => "Invalid username"}
     elsif instructor && instructor.authenticate(params[:instructor][:password])              
          cookies.permanent[:remember_token] = instructor.remember_token
          sign_in(instructor)
          redirect_to instructor_path(instructor.instructor_secret_code)
     else
          flash[:error] = "Try typing your password in correctly next time..."
          render :new
     end
end


def destroy
     cookies.delete(:remember_token)
     redirect_to new_session_path
end


end
