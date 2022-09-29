Rails.application.routes.draw do

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
    resources :users, only:[:show, :edit, :update]
    resources :teams, only:[:index, :edit, :create, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:new, :create, :index, :edit, :update]
  end
end
