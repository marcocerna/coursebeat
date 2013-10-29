require 'spec_helper'

describe Course do

	it 'should require a course name' do
		course = Course.create
		course.should_not == nil
	end
end