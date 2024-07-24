Rails.application.routes.draw do
  root 'quiz#index'
  post 'quiz/generate', to: 'quiz#generate'
end
