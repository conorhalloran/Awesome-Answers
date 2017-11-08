Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  # Note: we are not using the plural form of resources method. We are using 'resource' which will not generate routes that require an :id. Instead resource expects that our controller actions will always operate on the same resourse. Even though resource is written with a singular ':session', the controller must still be plural 'SessionsController'. 
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]


  # get('questions/new', to: 'questions#new', as: :new_question)
  # post('questions', to: 'questions#create', as: :questions)
  # get('questions', to: 'questions#index')
  # get('questions/:id', to: 'questions#show', as: :question)
  # # When creating a route with a match parameter (e.g. :id, :name, etc),
  # # you must provide that parameter as an argument to the generated method.
  # # (e.g. question_path(question.id), question_path(question), question_path(2))
  # patch('questions/:id', to: 'questions#update')
  # delete('questions/:id', to: 'questions#destroy')
  # get('questions/:id/edit', to: 'questions#edit', as: :edit_question)

  # `resources` method will generate all conventional CRUD routes for a name
  # at once. `resources :questions` will generate exactly the same routes
  # we wrote manually above ð.
  resources :questions do
    resources :answers, shallow: true, only: [:create, :destroy] do
          resources :votes, only: [:create, :destroy, :update]
      end
    # ð post('/questions/:question_id/answers', to: 'answers#create', as: question_answers_path)

    # Use `shallow: true` option to remove nesting for actions do not normally
    # require information from the parent resource (e.g. show, edit, destroy, update.)
    # DELETE /questions/:question_id/answers/:id becomes
    # DELETE /answers/:id
    resources :likes, shallow: true, only: [:create, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        # index -> /api/v1/questions
        resources :questions, only: [:index, :show, :create]
    end
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  
  # this defines a route as follows:
  # when we receive an HTTP GET request with URL: /hello
  # send this request to the WelcomeController and invoke the `hello` method
  # within that controller.
  # The router here expects Welcome controller to have a public instance method
  # called `hello`
  get('/hello', { to: 'welcome#hello', as: :hello })
  # by adding `as: :hello` Rails will generate URL helpers: hello_path &
  # hello_url which can be used in the views and controller to generate the urls

  get('/subscribe', { to: 'subscriptions#new', as: :subscribe })
  post('/subscribe', { to: 'subscriptions#create' })

  # get '/hello', to: 'welcome#hello'
  # get '/hello' => 'welcome#hello'

  # get('/', { to: 'welcome#index' })
  root 'welcome#index'
end