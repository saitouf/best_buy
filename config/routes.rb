Rails.application.routes.draw do

  # Actioncableの有効
  mount ActionCable.server => '/cable'

  # ゲストログイン用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root :to => "homes#top"
    get '/about' => 'homes#about'
    resources :post_items, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      resources :post_comments, only: [:create, :destroy, :new]
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:show,:edit,:update] do
    # いいね投稿確認のルーティング
      member do
        get "/customer/favorites" => "customers#favorites", as: "favorite_index"
      end
    end
    resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    # ランキングのルーティング
    get '/rank' => 'ranks#rank', as: 'rank'
    # 検索機能のルーティング
    get '/search' => 'post_items#search', as: 'search'
    get '/group_search' => 'groups#search', as: 'group_search'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update] do
    # いいねを付けた投稿確認のルーティング
      member do
        get "/customer/favorites" => "customers#favorites", as: "favorite_index"
      end
    end
    resources :post_items, only: [:index, :show, :destroy, :edit, :update] do
      resources :post_comments, only: [:destroy]
    end
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
     # ランキングのルーティング
    get '/rank' => 'ranks#rank', as: 'rank'
     # 検索機能のルーティング
    get '/search' => 'post_items#search', as: 'search'
    get '/group_search' => 'groups#search', as: 'group_search'
    get '/customer_search' => 'customers#search', as: 'customer_search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
