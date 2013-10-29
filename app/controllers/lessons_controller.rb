class LessonsController < ApplicationController
	skip_before_filter :authorize, except: [:new, :edit, :destroy]

def index
	@lessons = Lesson.all
end

def new
end

def create
	# Routed here from Ajax call in application.js
	# This is super messy, desperately needs refactoring
	course = Course.find_by_secret_code(params[:course_id])
	lesson = Lesson.create(title: params[:lesson], course_id: course.id, secret_code: SecureRandom.urlsafe_base64)
	if params["keyHash"]
		params["keyHash"].each do |num1, key_info|
			k = KeyConcept.create(info: key_info, lesson_id: lesson.id)
			if params["subHash"] 
				params["subHash"].each do |sub_info, num2|
					if num2 == num1
						SubConcept.create(info: sub_info, key_concept_id: k.id)
					end
				end
			end
		end
	end
	redirect_to course_path(params[:course_id])

end

def show
	@lesson = Lesson.find_by_secret_code(params[:id])
	@concepts = {}

	key_concepts = KeyConcept.where(lesson_id: @lesson.id)
	key_concepts.each do |key_concept|
		sub_concepts = SubConcept.where(key_concept_id: key_concept.id)
		@concepts[key_concept] = sub_concepts
	end

	# Ratings cookie (one vote/item) must be array, but browser saves as strings
	# We need special methods to convert it (defined in app controller)
	if read_cookies.empty?
		write_cookies([])
	end
end

def edit
end

def update
	sub_concept = SubConcept.find(params[:id])

	# We set ratingCount the first time b/c adding 1 to nil gives errors
	if sub_concept.ratingCount
		sub_concept.update_attributes(ratingAverage: ((sub_concept.ratingCount * sub_concept.ratingAverage + params[:rating].to_f) / (sub_concept.ratingCount.to_f + 1)).round(2) )
		sub_concept.update_attributes(ratingCount: sub_concept.ratingCount + 1)
	else
		sub_concept.update_attributes(ratingAverage: params[:rating])		
		sub_concept.update_attributes(ratingCount: 1)
	end

	cookies = read_cookies			# b/c we can't shovel into a method
	cookies << sub_concept.id
	write_cookies(cookies)			# To keep track of what's been voted on

	# Redirect
	lesson = sub_concept.key_concept.lesson.secret_code
	redirect_to "/lessons/" + lesson
end

def destroy
	course = Lesson.find(params[:id]).course 			# error if not first
	Lesson.destroy(params[:id])
	redirect_to course_path(course.secret_code)
end
end
