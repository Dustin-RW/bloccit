Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  #use only [] because we do not want to create any /posts/:id routes, just
  #/posts/:post_id/comments
  resources :posts, only: [] do
  #only add create and destroy routes for comments.  Comments will be displayed
  #in #posts show view.
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root 'welcome#index'
end
