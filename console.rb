require_relative("models/casting.rb")
require_relative("models/movie.rb")
require_relative("models/star.rb")

Movie.delete_all
Star.delete_all
Casting.delete_all

Movie.all
Star.all
Casting.all

require('pry-byebug')

movie1 = Movie.new({'title' => 'Kung Fu Panda', 'genre' => 'Cartoon', 'budget' => 50_000})
movie1.save
movie2 = Movie.new({'title' => '007', 'genre' => 'Action', 'budget' => 90_000})
movie2.save

star1 = Star.new({'first_name' => 'Jakie', 'last_name' => 'Chan'})
star1.save
star2 = Star.new({'first_name' => 'Tom', 'last_name' => 'Cruise'})
star2.save

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 20_000})
casting1.save
casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 40_000})
casting2.save
casting3 = Casting.new({'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 30_000})
casting3.save

movie2.genre = 'Romantic'
movie2.update

star2.last_name = 'Hardy'
star2.update

casting1.fee = 1_000
casting1.update

movie2.budget = 80_000
movie2.update

binding.pry
nil
