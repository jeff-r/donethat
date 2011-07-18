Donethat::Application.routes.draw do
  resources :events

  devise_for :users

  resources :projects

  root :to => "projects#index"

  match '/add_file_event/:project_id/:event_filename/:event_time/', :to => 'events#create'


end
