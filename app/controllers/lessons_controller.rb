class LessonsController < ApplicationController

def index
	@lessons = Lesson.all
end

def new
	@lesson = Lesson.new
	@key_concept = KeyConcept.new
	@sub_concept = SubConcept.new
end

def create
	lesson = Lesson.create(title: params["lesson"])
	# binding.pry
	unless params["keyHash"] == nil
		params["keyHash"].each do |num1, key_info|
			k = KeyConcept.create(info: key_info, lesson_id: lesson.id)
			unless params["subHash"] == nil
				params["subHash"].each do |sub_info, num2|
					if num2 == num1
						SubConcept.create(info: sub_info, key_concept_id: k.id)
					end
				end
			end
		end
	end

	redirect_to lessons_path
end

def show
	@lesson = Lesson.find(params[:id])
	@concepts = {}
	@key_concepts = KeyConcept.where(lesson_id: @lesson.id)
	@key_concepts.each do |key_concept|
		@sub_concepts = SubConcept.where(key_concept_id: key_concept.id)
		@concepts[key_concept] = @sub_concepts
	end
end

def edit
end

def update
	@sub_concept = SubConcept.find(params[:id])
	if @sub_concept.ratingCount == nil
		@sub_concept.update_attributes(ratingAverage: params[:rating])		
		@sub_concept.update_attributes(ratingCount: 1)
	else
		@sub_concept.update_attributes(ratingAverage: ((@sub_concept.ratingCount * @sub_concept.ratingAverage + params[:rating].to_f) / (@sub_concept.ratingCount.to_f + 1)).round(2) )
		@sub_concept.update_attributes(ratingCount: @sub_concept.ratingCount + 1)
	end
	lesson = @sub_concept.key_concept.lesson
	redirect_to lesson
end

def destroy
	lesson = Lesson.destroy(params[:id])
	redirect_to lessons_path
end
end
