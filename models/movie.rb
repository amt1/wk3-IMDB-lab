require_relative('../db/sql_runner.rb')
require_relative('./performer.rb')

class Movie

attr_accessor :title, :genre
attr_reader :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @id = options['id'].to_i if options['id']
end

def save
  sql = "INSERT INTO movies (title, genre) VALUES ($1, $2) RETURNING id;"
  values = [@title, @genre]
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
    sql = 'UPDATE movies SET (title, genre) = ($1, $2) WHERE id = $3;'
       values = [options['title'], options['genre'], @id]
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
end # end class
