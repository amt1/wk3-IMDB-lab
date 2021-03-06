require_relative('../db/sql_runner.rb')
require_relative('./performer.rb')

class Movie

attr_accessor :title, :genre, :budget
attr_reader :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @budget = options['budget']
  @id = options['id'].to_i if options['id']
end

def save
  sql = "INSERT INTO movies (title, genre, budget) VALUES ($1, $2, $3) RETURNING id;"
  values = [@title, @genre, @budget]
  returned_id = SqlRunner.run(sql, values).first['id']
  @id = returned_id.to_i
end

def self.delete_all
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end


  def delete
    sql = "DELETE FROM movies WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_my_movies(movie_hash)
    return movie_hash.map { |movie| Movie.new(movie)  }
  end

  def self.list_all
    sql = "SELECT * FROM movies"
    movie_list = SqlRunner.run(sql)
    return map_my_movies(movie_list)
  end

  def update(options)
    sql = 'UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4;'
       values = [options['title'], options['genre'], options['budget'], @id]
      SqlRunner.run(sql, values)
  end


      def list_performers
        sql="SELECT performers.* FROM performers
  INNER JOIN castings ON performers.id = performer_id
  WHERE movie_id = $1;"
    values=[@id]
    performer_hash = SqlRunner.run(sql, values)
    return Performer.map_my_performers(performer_hash)
      end

# extensions from class: ruby method, but sql can do it too

def remaining_budget()
  castings = self.castings #  (function that lists castings for movies)
  casting_fees = castings.map { |casting|  casting.fee }
  combined_fees = casting_fees.sum
  return @budget - combined_fees
end

# sql way:
def remaining_budget_2
sql = "SELECT SUM(castings.fee) FROM movies
INNER JOIN castings on movies.id = castings.movie_id WHERE movies.id = $1"
better_sql = "SELECT SUM(castings.fee) FROM castings WHERE movie_id = $1"
values = [@id]
return SqlRunner.run(better_sql, values).first["sum"].to_i
end # end class
