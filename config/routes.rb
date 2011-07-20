Donethat::Application.routes.draw do
  devise_for :users

  resources :events, :projects, :users

  root :to => "projects#index"

  match '/add_file_event/:project_id/:event_filename/:event_time/', :to => 'events#create'


end
