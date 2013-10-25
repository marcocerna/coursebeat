class InstructorsController < ApplicationController
skip_before_filter :authorize, only: [:new, :create]

def new
	@instructor = Instructor.new
end

def create
    @instructor = Instructor.create(params[:instructor])
    @instructor.update_attributes(instructor_secret_code: SecureRandom.urlsafe_base64)
	if @instructor.errors.empty?
		InstructorMailer.welcome_email(@instructor).deliver
		sign_in(@instructor)
		redirect_to instructor_path(@instructor.instructor_secret_code) 
	else
		flash[:errors] = @instructor.errors.full_messages
		render :new
	end

end

def show
	@instructor = current_user
	@courses = @instructor.courses
	session[:instructor_id] = params[:id]
	# binding.pry
end

def edit
	@instructor = current_user
end

def update
	flash[:info] = "Your account has been updated"
	instructor = Instructor.find_by_instructor_secret_code(params[:id])
	instructor.update_attributes(username: params[:instructor][:username], email: params[:instructor][:email])
	redirect_to instructor_path(current_user.instructor_secret_code)
end

def destroy
	# Instructor.destroy()
end
end