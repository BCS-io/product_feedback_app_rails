Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root "suggestions#index"

  resources :feedbacks, only: [:new, :create, :edit, :update, :destroy] do
    #
    # module is to make different commentable objects (feedback in this case)
    # go to different controllers
    #
    resources :comments, module: :feedbacks, only: [:create]
  end
  resources :suggestions, only: [:show]
  resources :votes, only: [:create, :destroy]

  if Rails.env.development?
    resources :design_system_docs, only: [:index]
  end
end
