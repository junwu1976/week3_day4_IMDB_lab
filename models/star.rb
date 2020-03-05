require_relative("../db/sql_runner")

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize( stars )
    @id = stars['id'].to_i if stars['id']
    @first_name = stars['first_name']
    @last_name = stars['last_name']
  end

  def save
    sql = "INSERT INTO stars (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    result = stars.map { |star| Star.new( star ) }
    return result
  end

  def update
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def movies
    sql = "SELECT movies.* FROM movies INNER JOIN castings ON movies.id = castings.movie_id WHERE star_id = $1"
    value = [@id]
    movies = SqlRunner.run(sql, value)
    return movies.map {|movie| Movie.new(movie)}
  end

end
