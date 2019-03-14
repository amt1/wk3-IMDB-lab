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

end # end class
