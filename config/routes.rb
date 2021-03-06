Rails.application.routes.draw do
  devise_for  :users
  root        'groups#index'
  resources   :groups, only: [:new, :create, :show, :edit, :update]
  resources   :messages, only: [:create] do
    collection do
      get 'reload'
    end
  end
  get         'users/search'  => 'users#search'
end
