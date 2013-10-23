class CoursesController < ApplicationController
skip_before_filter :authorize, only: [:show]

def new
	@course = Course.new
end

def create
	binding.pry
	@course = Course.create(class_name: params[:course][:class_name], secret_code: SecureRandom.urlsafe_base64)
	redirect_to course_code_path(@course.secret_code)
end

def show
	# binding.pry
	@lessons = []
	@courses = []
	if current_user
		current_user.courses.each do |course|
			@lessons += course.lessons
		end
	else
		@courses += Course.where(secret_code: params[:id])
		@courses.each do |course|
						binding.pry	
			@lessons += Lesson.where(course_id: course.id)
		end
	end

end

end
