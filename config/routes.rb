Rails.application.routes.draw do
  root to: 'quiz#new'
  resources :quiz
end
