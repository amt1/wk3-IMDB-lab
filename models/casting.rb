require_relative('../db/sql_runner.rb')


class Casting

  attr_accessor :movie_id, :performer_id, :fee
  attr_reader :id

  def initialize(options)
    @movie_id = options['movie_id'].to_i
    @performer_id = options['performer_id'].to_i
    @fee = options['fee'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO castings (movie_id, performer_id, fee) VALUES ($1, $2, $3) RETURNING id;"
    values = [@movie_id, @performer_id, @fee]
    returned_id = SqlRunner.run(sql, values).first['id']
    @id = returned_id.to_i
  end

  def self.delete_all
    sql = "DELETE FROM castings;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM castings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

    def self.map_my_castings(castings_hash)
      return castings_hash.map { |casting| Casting.new(casting)  }
    end

    def self.list_all
      sql = "SELECT * FROM castings"
      casting_list = SqlRunner.run(sql)
      return map_my_castings(casting_list)
    end
end # end class
