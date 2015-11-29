require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'Find other movies with same director' do

    before(:all) do
      Movie.all.each { |movie| movie.delete} if Movie.all.count > 0
      @movie_with_director = build(:movie, id: 3, title: 'Alien', director: 'Ridley Scott') 
      @movie_with_director.save

      @movie_with_same_director = build(:movie, id: 7, title: 'Blade Runner', director: 'Ridley Scott') 
      @movie_with_same_director.save

      @movie_with_different_director = build(:movie, id: 6, title: 'Star Wars', director: 'Georges Lucas') 
      @movie_with_different_director.save

      @movie_with_no_director = build(:movie, id: 8, title: 'Abyss', director: nil) 
      @movie_with_no_director.save
    end
    
    describe "When there is a director" do
      it 'should find movies by the same director' do
        @movies = Movie.find_same_director_movies(@movie_with_director)
        expect(@movies).to eq [@movie_with_same_director]
      end

      it 'is not expected to find movies with dfferent directors' do
        @movies = Movie.find_same_director_movies(@movie_with_different_director)
        expect(@movies).to eq []
     end
    end 
    
    after(:all) do
      @movie_with_director.delete
      @movie_with_no_director.delete
      @movie_with_same_director.delete
      @movie_with_different_director.delete
    end
  end
end
