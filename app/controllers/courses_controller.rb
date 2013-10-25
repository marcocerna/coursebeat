class CoursesController < ApplicationController
skip_before_filter :authorize, only: [:show]

def new
	@course = Course.new
end

def create
	if params[:course][:course_name] == ""
		flash[:errors] = "You must enter a valid course name"
		redirect_to new_course_path
	elsif params[:instructors] == nil
		flash[:errors] = "You must include at least one valid instructor"
		redirect_to new_course_path
	else
		instructor = nil
		params[:instructors].each do |num, username|
			instructor = Instructor.find_by_username(username)
			unless instructor == nil
				@course = Course.create(course_name: params[:course][:course_name], secret_code: SecureRandom.urlsafe_base64)
				CourseInstructor.create(course_id: @course.id, instructor_id: instructor.id)
				flash[:alert] = "Your course has been created."
			else
				flash[:errors] = "That instructor username doesn't exist!"
			end
		end
		if instructor
			redirect_to instructor_path(current_user.instructor_secret_code)
		else
			redirect_to new_course_path
		end
	end
end

def show
	@course = Course.find_by_secret_code(params[:id])
end

def edit
	@course = Course.find_by_secret_code(params[:id])
end

def update
	binding.pry
	course = Course.find_by_secret_code(params[:id])
	course.update_attributes(course_name: params[:course][:course_name])
	if params[:instructors]
		params[:instructors].each do |key, name|
			instructor = Instructor.find_by_username(name)
			CourseInstructor.create(course_id: course.id, instructor_id: instructor.id)
		end
	end
	redirect_to course_path(params[:id])
end

def destroy
	lesson = Course.destroy(params[:id])
	flash[:error] = lesson.course_name + " has been deleted"
	redirect_to instructor_path(session[:instructor_id])

end

end
