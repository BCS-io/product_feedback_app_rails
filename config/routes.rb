Rails.application.routes.draw do
  root "suggestions#index"

  if Rails.env.development?
    resources :design_system_docs, only: [:index]
  end
end
