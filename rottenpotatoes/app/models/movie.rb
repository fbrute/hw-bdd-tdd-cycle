class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_same_director_movies(movie)
    Movie.where('director = ?', movie.director).reject {|movie_found| movie_found.id == movie.id}
  end
end
