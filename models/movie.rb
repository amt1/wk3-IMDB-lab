require_relative('../db/sql_runner.rb')

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

end # end class
