Rails.application.routes.draw do
  devise_for :users

  # get 'articles/index'

  root to: "articles#index"

  resources :articles do
    # nesting routes for comments
    resources :comments
    # rails routes | grep comments
      #  grabs all comment routes
  end

  mount ActionCable.server => '/cable'

end
