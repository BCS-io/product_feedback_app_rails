Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root "suggestions#index"

  if Rails.env.development?
    resources :design_system_docs, only: [:index]
  end
end
