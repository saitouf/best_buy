Rails.application.routes.draw do
  
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  scope module: :public do
    root :to => "homes#top"
    resources :post_items, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    # root :to => "homes#top"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
