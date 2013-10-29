class CoursesController < ApplicationController
skip_before_filter :authorize, only: [:show]

def new
	@course = Course.new
end

def create
	# Check for presence of title and valid instructor
	if params[:course][:course_name] == ""
		redirect_to new_course_path, :flash => { :error => "Invalid course name"}
		return
	elsif params[:instructors] == nil
		redirect_to new_course_path, :flash => { :error => "Must include at least one valid instructor"}
		return
	end

	# Check that all instructors are valid
	params[:instructors].each do |num, username|
		instructor = Instructor.find_by_username(username)
		unless instructor
			redirect_to new_course_path, :flash => { :error => "Invalid instructor username"}
			return
		end
	end

	# Create course and join table entry for each instructor
	@course = Course.create(course_name: params[:course][:course_name], secret_code: SecureRandom.urlsafe_base64)
	params[:instructors].each do |num, username|
		instructor = Instructor.find_by_username(username)
		CourseInstructor.create(course_id: @course.id, instructor_id: instructor.id)
	end

	flash[:alert] = "Your course has been created."
	redirect_to instructor_path(current_user.instructor_secret_code)
end

def show
	@course = Course.find_by_secret_code(params[:id])
end

def edit
	@course = Course.find_by_secret_code(params[:id])
end

def update
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

def remove_instructor
	# This will be added later
	redirect_to edit_course_path(params[:id])
end

def destroy
	lesson = Course.destroy(params[:id])
	flash[:error] = lesson.course_name + " has been deleted"
	redirect_to instructor_path(session[:instructor_id])

end
end
