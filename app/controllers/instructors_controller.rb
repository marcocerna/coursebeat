class InstructorsController < ApplicationController

def new
	@instructor = Instructor.new
end

def create
    @instructor =Instructor.create(params[:instructor])
	if @instructor.errors.empty?
		redirect_to instructor_path(instructor.id) 
	else
		flash[:errors] = @instructor.errors.full_messages
		render :new
	end
end

def show
     @instructor = current_user
end

end
