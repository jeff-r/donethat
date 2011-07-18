Donethat::Application.routes.draw do
  resources :projects

  root :to => "projects#index"

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/sign_out', :to => 'sessions#sign_out', :as => "sign_out"

  match '/add_file_event/:project_id/:event_filename/:event_time/', :to => 'events#create'


end
