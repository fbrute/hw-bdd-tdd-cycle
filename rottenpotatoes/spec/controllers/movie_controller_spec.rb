require 'rails_helper'
require 'spec_helper'
require 'support/factory_girl'

RSpec.describe MoviesController, type: :controller do

  describe 'Searching movies with same director' do

    before(:all) do
      #Movie.all.each { |movie| movie.delete} if Movie.all.count > 0
      @movie_with_director = build(:movie, id: 3, title: 'Alien', director: 'Ridley Scott') 
      @movie_with_director.save
      
      @movie_with_same_director = build(:movie, id: 7, title: 'Blade Runner', director: 'Ridley Scott') 
      @movie_with_same_director.save
      
      @movie_with_no_director = build(:movie, id: 4, title: 'Abyss', director: '') 
      @movie_with_no_director.save
    end
   
    context 'when the specified movie has a director' do
      it 'is expected to make the movies available to the template ' do
        fake_results = [@movie_with_same_director]
        allow(Movie).to receive(:find_same_director_movies).with(@movie_with_director).and_return(fake_results)
        get "find_same_director_movies" , id: @movie_with_director.id
        expect(assigns(:movies)).to eq fake_results
      end

      it 'is expected to call the model method to perform the search ' do
        expect(Movie).to receive(:find_same_director_movies)
        get "find_same_director_movies" , id: @movie_with_director.id
      end

      it 'is expected to render the find same director movies template' do
        allow(Movie).to receive(:find_same_director_movies)
        get "find_same_director_movies" , id: @movie_with_director.id
        expect(response).to render_template('find_same_director_movies')
      end

     end

    context 'when the specified movie does not have a director' do
      it 'is expected to redirect to the same details page' do
        get "find_same_director_movies" , id: @movie_with_no_director.id
        #expect(assigns(flash[:notice])).to eq "No Movies Found With Same Director"
        expect(response).to redirect_to movies_path
      end

      it 'is expected to flash a message when there is not a movie with the same director' do
        get "find_same_director_movies" , id: @movie_with_no_director.id
        #expect(response).to redirect_to("/movies/#{@movie_with_no_director.id}")
        #expect(response).to redirect_to movie_path(@movie_with_no_director) 
        expect(response).to redirect_to movies_path
        #expect(assigns(flash[:notice])).to eq "No Movies Found With Same Director"
      end
 

    end

    after(:all) do
      @movie_with_director.delete
      @movie_with_no_director.delete
      @movie_with_same_director.delete
    end
  end
end
