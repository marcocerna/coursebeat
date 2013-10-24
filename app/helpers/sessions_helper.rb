module SessionsHelper

 def sign_in(instructor)
    cookies.permanent[:remember_token] = instructor.remember_token
 end
    
 def sign_out
    cookies.delete(:remember_token)
 end

 def current_user
    @current_user ||= Instructor.find_by_remember_token(cookies[:remember_token])
 end

end
 