class CoursesController < ApplicationController
skip_before_filter :authorize, only: [:show]

def new
	@course = Course.new
end

def create
	@course = Course.create(class_name: params[:course][:class_name], secret_code: SecureRandom.urlsafe_base64)
	redirect_to instructor_path(current_user.instructor_secret_code)
	flash[:alert] = "Your course has been created."
end

def show
	@lessons = []
	@courses = []
	if current_user
		current_user.courses.each do |course|
			@lessons += course.lessons
		end
	else
		@courses += Course.where(secret_code: params[:id])
		@courses.each do |course|
			@lessons += Lesson.where(course_id: course.id)
		end
	end
	@course = Course.find_by_secret_code(params[:id])
end

end
