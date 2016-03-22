Rails.application.routes.draw do

  # HTTP is the protocol that the Internet uses to communicate
  # with websites. The get action corresponds to the HTTP GET
  # verb. GET requests are used to retrieve information
  # identified by the URL.

  resources :labels, only: [:show]

  resources :topics do
    resources :posts, except: [:index]
  end

  # use only [] because we do not want to create any /posts/:id routes, just
  # /posts/:post_id/comments
  resources :posts, only: [] do
  #only add create and destroy routes for comments.  Comments will be displayed
  #in #posts show view.
    resources :comments, only: [:create, :destroy]
  end

  # The only hash key will prevent Rails from creating unnecessary routes
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  # route not needed since welcome#index is root
  #get 'welcome/index'

  # The root method allows us to declare the default page the app
  # loads when we navigate to the home page URL.
  root 'welcome#index'

end
