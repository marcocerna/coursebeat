require 'spec_helper'

describe InstructorsController do

	describe "GET #new" do

		it "should render new" do
			get :new
			response.should render_template :new
		end
	end

	describe "GET #show" do

		it "should render show" do
			get :show
			response.should render_template :show
		end

	end
 
end