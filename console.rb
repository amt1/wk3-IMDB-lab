require_relative('./models/movie.rb')
require_relative('./models/performer.rb')
require_relative('./models/casting.rb')

Casting.delete_all
Movie.delete_all
Performer.delete_all

movie1 = Movie.new({'title' => 'The Godfather', 'genre' => 'Drama', 'budget' => '20000000'})
movie2 = Movie.new({'title' => 'Alien', 'genre' => 'Horror', 'budget' => '99999999'})
movie3 = Movie.new({'title' => 'Being John Malkovich', 'genre' => 'Drama', 'budget' => '10000'})

movie1.save
movie2.save
movie3.save

movie1.update({'title' => 'The Godfather', 'genre' => 'Romantic Comedy', 'budget' => movie1.budget})
# p Movie.list_all

# movie1.delete

performer1 = Performer.new({'first_name' => 'David', 'last_name' => 'Boyle'})
performer2 = Performer.new({'first_name' => 'Marlon', 'last_name' => 'Brando'})
performer3 = Performer.new({'first_name' => 'George', 'last_name' => 'Clooney'})

performer1.save
performer2.save
performer3.save

performer3.update({'first_name' => 'George', 'last_name' => 'SmileyDentist'})
# p Performer.list_all

# performer2.delete

casting1 = Casting.new({'movie_id' => movie2.id, 'performer_id' => performer1.id, 'fee' => '1000000'})
casting2 = Casting.new({'movie_id' => movie3.id, 'performer_id' => performer1.id, 'fee' => '10000000'})
casting3 = Casting.new({'movie_id' => movie2.id, 'performer_id' => performer3.id, 'fee' => '100'})
casting1.save
casting2.save
casting3.save
p movie2.list_performers
p performer1.list_movies

# casting2.fee = casting2.fee **2
# casting2.update
# new_fee = casting2.fee **2
casting2.update({'fee' => '1'})
casting2.update({'movie_id' => movie1.id, 'performer_id'=> casting2.performer_id, 'fee'=> '45629467'})

Casting.list_all

# casting1.delete
