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
	if @sub_concept.ratingAverage == nil
		@sub_concept.update_attributes(ratingAverage: params[:rating])
	else
		@sub_concept.update_attributes(ratingAverage: ((@sub_concept.ratingCount * @sub_concept.ratingAverage + params[:rating].to_f) / (@sub_concept.ratingCount.to_f + 1)).round(2) )
	end
	@sub_concept.update_attributes(ratingCount: @sub_concept.ratingCount + 1)
	lesson = @sub_concept.key_concept.lesson
	redirect_to lesson
end

end
