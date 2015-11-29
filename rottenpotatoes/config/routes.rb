Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/movies/find_same_director_movies/:id', to: 'movies#find_same_director_movies', as: :search_directors
end
