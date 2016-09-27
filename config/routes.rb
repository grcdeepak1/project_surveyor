Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'surveys#index'

  resources :surveys do
    resources :questions
  end
  resources :answers, only: [:create, :update]
  patch '/surveys/:survey_id/create_answer', to: 'surveys#create_answer', as: 'surveys_create_answer'

  get '/questions/:id/edit_options', to: 'questions#edit_options', as: 'question_edit_options'
  patch '/questions/:id/update_options', to: 'questions#update_options', as: 'question_update_options'

end