Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    resources :items, only: [:index, :show]

    get "/about" => "homes#about", as: "about"
    resources :cart_items, only: [:index, :update, :destroy, :create] do
    delete :destroy_all, on: :collection
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  namespace :admin do
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get "/admin" => "homes#top"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_details, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end