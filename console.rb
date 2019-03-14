require_relative('./models/movie.rb')
require_relative('./models/performer.rb')
require_relative('./models/casting.rb')

Casting.delete_all
Movie.delete_all
Performer.delete_all

movie1 = Movie.new({'title' => 'The Godfather', 'genre' => 'Drama'})
movie2 = Movie.new({'title' => 'Alien', 'genre' => 'Horror'})
movie3 = Movie.new({'title' => 'Being John Malkovich', 'genre' => 'Drama'})

movie1.save
movie2.save
movie3.save

movie1.delete

performer1 = Performer.new({'first_name' => 'David', 'last_name' => 'Boyle'})
performer2 = Performer.new({'first_name' => 'Marlon', 'last_name' => 'Brando'})
performer3 = Performer.new({'first_name' => 'George', 'last_name' => 'Clooney'})

performer1.save
performer2.save
performer3.save
performer2.delete

casting1 = Casting.new({'movie_id' => movie2.id, 'performer_id' => performer1.id, 'fee' => '1000000'})
casting2 = Casting.new({'movie_id' => movie3.id, 'performer_id' => performer1.id, 'fee' => '10000000'})

casting1.save
casting2.save
casting1.delete
