class InstructorMailer < ActionMailer::Base
  default from: "marco.a.cerna@gmail.com"

def welcome_email(instructor)
	@instructor = instructor
	mail(to: @instructor.email, subject: "Welcome to CourseBeat!")
end

 
end
