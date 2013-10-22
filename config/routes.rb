Coursebeat::Application.routes.draw do
  resources :lessons
  resources :instructors, except: [:index]
  resources :sessions, only: [:new, :create]


  root to: "lessons#index"

  post "/lessons/:id/update", to: "lessons#update"

  get '/logout' => "sessions#destroy"

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

