require_relative('./models/movie.rb')
require_relative('./models/performer.rb')
require_relative('./models/casting.rb')

movie1 = Movie.new({'title' => 'The Godfather', 'genre' => 'Drama'})
movie2 = Movie.new({'title' => 'Alien', 'genre' => 'Horror'})

movie1.save
movie2.save

performer1 = Performer.new({'first_name' => 'David', 'last_name' => 'Boyle'})
performer2 = Performer.new({'first_name' => 'Marlon', 'last_name' => 'Brando'})
performer1.save
performer2.save

casting1 = Casting.new({'movie_id' => movie2.id, 'performer_id' => performer1.id, 'fee' => '1000000'})
casting1.save
