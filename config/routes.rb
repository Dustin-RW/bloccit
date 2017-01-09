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
    # only add create and destroy routes for comments.  Comments will be displayed
    # in #posts show view.
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    # create POST routes at the URL posts/:id/up-vote
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    # create POST routes at the URL posts/:id/down_vote
    post 'down-vote' => 'votes#down_vote', as: :down_vote
  end

  # The only hash key will prevent Rails from creating unnecessary routes
  resources :users, only: [:new, :create, :show]
  # The only hash key will prevent Rails from creating unnecessary routes
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  # route not needed since welcome#index is root
  # get 'welcome/index'

  # The root method allows us to declare the default page the app
  # loads when we navigate to the home page URL.
  root 'welcome#index'
  # added two new namespaces: api and v1.
  # v1 is nested under api to create a URI of /api/v1/
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]
      resources :topics, except: [:edit, :new]
    end
  end
end
