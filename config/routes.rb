Coursebeat::Application.routes.draw do

  resources :lessons, except: [:new, :create]
  resources :instructors, except: [:index]
  resources :sessions, only: [:new, :create]
  resources :courses do
  	resources :lessons, only: [:new, :create]
  end

  get '/courses/:secret_code', to: "courses#show", as: "course_code"
  # get '/instructors/:instructor_secret_code', to: "instructors#show", as: "instructor_code" 

  root to: "lessons#index"

post "/lessons/:id/update", to: "lessons#update"

  get '/logout' => "sessions#destroy"

  match '*path' => redirect('/')

# $ rake routes
#        root        /                             lessons#index
#             POST   /lessons/:id/update(.:format) lessons#update
#     lessons GET    /lessons(.:format)            lessons#index
#             POST   /lessons(.:format)            lessons#create
#  new_lesson GET    /lessons/new(.:format)        lessons#new
# edit_lesson GET    /lessons/:id/edit(.:format)   lessons#edit
#      lesson GET    /lessons/:id(.:format)        lessons#show
#             PUT    /lessons/:id(.:format)        lessons#update
#             DELETE /lessons/:id(.:format)        lessons#destroy
end

# $ rake routes
#         lessons GET    /lessons(.:format)              lessons#index
#                 POST   /lessons(.:format)              lessons#create
#      new_lesson GET    /lessons/new(.:format)          lessons#new
#     edit_lesson GET    /lessons/:id/edit(.:format)     lessons#edit
#          lesson GET    /lessons/:id(.:format)          lessons#show
#                 PUT    /lessons/:id(.:format)          lessons#update
#                 DELETE /lessons/:id(.:format)          lessons#destroy
#     instructors POST   /instructors(.:format)          instructors#create
#  new_instructor GET    /instructors/new(.:format)      instructors#new
# edit_instructor GET    /instructors/:id/edit(.:format) instructors#edit
#      instructor GET    /instructors/:id(.:format)      instructors#show
#                 PUT    /instructors/:id(.:format)      instructors#update
#                 DELETE /instructors/:id(.:format)      instructors#destroy
#        sessions POST   /sessions(.:format)             sessions#create
#     new_session GET    /sessions/new(.:format)         sessions#new
#         courses GET    /courses(.:format)              courses#index
#                 POST   /courses(.:format)              courses#create
#      new_course GET    /courses/new(.:format)          courses#new
#     edit_course GET    /courses/:id/edit(.:format)     courses#edit
#          course GET    /courses/:id(.:format)          courses#show
#                 PUT    /courses/:id(.:format)          courses#update
#                 DELETE /courses/:id(.:format)          courses#destroy
#            root        /                               lessons#index
#                 POST   /lessons/:id/update(.:format)   lessons#update
#          logout GET    /logout(.:format)               sessions#destroy
