Rails.application.routes.draw do
  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'terms' => 'welcome#terms'

  resources :items, only: [ :index, :show, :new, :create ] do
    collection do
      get 'list'
    end
  end
  resources :appointments, only: [ :index, :show, :create ]

  # マイページ
  namespace 'mypage' do
    root to: 'mypage#index'

    # TODO: アイテム出品、プロフィール編集を mypage 配下の URL に

    resources :items, only: [ :index ] do
      member do
        put 'activate'
        put 'deactivate'
      end
    end

    resources :appointments, only: [ :index ] do
      collection do
        get 'reserved'
      end
    end

    resources :messages, only: [] do
      collection do
        get 'users'
        get 'users/:id', to: 'messages#index'
        post 'users/:id', to: 'messages#create'
      end
    end
  end

  # メッセージ
  resources :messages, only: [ :create ]

  #resource :mypage, only: [ :show ] do
  resource :mypage, only: [] do
    # メッセージ
    resources :users, only: [ :index ] do
      resources :messages, only: [ :index, :create ]
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # omniauth_callbacks: 'omniauth_callbacks'
  }

  # お仕事マッチング
  namespace 'works' do
    root to: 'static#top'

    devise_for :users, controllers: {
      registrations: 'works/users/registrations',
      sessions: 'works/users/sessions'
    }
  end

  # API
  resources :japan_cities, only: [ :index ]

  # 管理画面
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }

  namespace 'admin' do
    root to: 'welcome#index'

    resources :users
    resources :items
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
