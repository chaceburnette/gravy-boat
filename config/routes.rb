Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
  resources :patients

  get 'patients/:patient_id/mri_images' => 'mri_images#index'
  get 'patients/:patient_id/mri_images/new' => 'mri_images#new'
  get 'patients/:patient_id/mri_images/:id' => 'mri_images#show'
  post 'patients/:patient_id/mri_images/new' => 'mri_images#create'
end
