Rails.application.routes.draw do
  root to: 'quiz#new'
  resources :quiz, only: [:new, :create]
end
