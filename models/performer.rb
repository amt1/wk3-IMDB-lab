require_relative('../db/sql_runner.rb')


class Performer

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO performers (first_name, last_name) VALUES ($1, $2) RETURNING id;"
    values = [@first_name, @last_name]
    returned_id = SqlRunner.run(sql, values).first['id']
    @id = returned_id.to_i
  end

  def self.delete_all
    sql = "DELETE FROM performers"
    SqlRunner.run(sql)
  end


    def delete
      sql = "DELETE FROM performers WHERE id = $1;"
      values = [@id]
      SqlRunner.run(sql, values)
    end

      def self.map_my_performers(performer_hash)
        return performer_hash.map { |performer| Performer.new(performer)  }
      end

      def self.list_all
        sql = "SELECT * FROM performers"
        performer_list = SqlRunner.run(sql)
        return map_my_performers(performer_list)
      end

      def update(options)
        sql = 'UPDATE performers SET (first_name, last_name) = ($1, $2) WHERE id = $3;'
           values = [options['first_name'], options['last_name'], @id]
          SqlRunner.run(sql, values)
      end
end
