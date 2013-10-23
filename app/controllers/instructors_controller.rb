class InstructorsController < ApplicationController
skip_before_filter :authorize, only: [:new, :create]

def new
	@instructor = Instructor.new
end

def create
    @instructor = Instructor.create(params[:instructor])
    @instructor.update_attributes(instructor_secret_code: SecureRandom.urlsafe_base64)
	if @instructor.errors.empty?
		redirect_to instructor_path(@instructor.secret_code) 
		sign_in(@instructor)
	else
		flash[:errors] = @instructor.errors.full_messages
		render :new
	end
end

def show
     @instructor = current_user
     @courses = @instructor.courses
end

end
