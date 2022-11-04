Rails.application.routes.draw do
  root to: 'home#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'log_in', to: 'sessions#new'
  post 'log_in', to: 'sessions#create'

  delete 'log_out', to: 'sessions#delete'
end
