
Rails.application.routes.draw do
  get '/parse_log', to: 'game_matches#parse_log', as: :parse_log
  resources :game_matches  
end
