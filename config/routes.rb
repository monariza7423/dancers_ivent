Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 顧客用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
   root to: "homes#top"
  
  scope module: :public do
    get '/about' => 'homes#about', as: 'about'
    resources :users, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :teams, only:[:index, :edit, :create, :update, :destroy]
    resources :competitions, only:[:new, :create, :index, :show, :edit, :update, :destroy]
    resources :events, only:[:new, :create, :index, :show] do
      resource :favorites, only:[:create, :destroy]
      resources :event_comments, only:[:create]
    end
    # 検索機能
    get "search" => "searches#search"
    # タグ検索
    get "search_tag"=>"events#search_tag"
    # 通知機能
    resources :notifications, only:[:index]
  end
  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:new, :create, :index, :edit, :update]
  end
end
