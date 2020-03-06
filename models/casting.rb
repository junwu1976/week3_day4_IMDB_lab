require_relative("../db/sql_runner")

class Casting

  attr_reader :id, :movie_id, :star_id
  attr_accessor :fee

  def initialize(castings)
    @id = castings['id'].to_i if castings['id']
    @movie_id = castings['movie_id'].to_i
    @star_id = castings['star_id'].to_i
    @fee = castings['fee']
  end

  def save
    sql = "INSERT INTO castings (movie_id, star_id, fee) VALUES ($1, $2, $3) RETURNING id"
    values = [@movie_id, @star_id, @fee]
    casting = SqlRunner.run(sql, values).first
    @id = casting['id'].to_i
#    reduce budget from movie
#    movie1 = Movie.get_movie_by_id(@movie_id)
#    if(movie1.budget >= @fee)
# =>    movie1.budget -= @fee
# => end
# => movie1.update
    movie_found = Casting.get_movie_by_id(@movie_id)
    # binding.pry

    if(movie_found.budget.to_i >= @fee)
      new_budget = movie_found.budget.to_i - @fee
      movie_found.budget = new_budget.to_s
      # movie_found.budget.to_i -= @fee
    else
      p "Sorry, out of budget"
    end
    movie_found.update
  end

  def self.get_movie_by_id(id)
    sql = "SELECT * FROM movies WHERE id = $1"
    value = [id]
    movie_found = SqlRunner.run(sql, value).first
    return Movie.new(movie_found)
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    castings = SqlRunner.run(sql)
    result = castings.map { |casting| Casting.new( casting ) }
    return result
  end

  def update
    sql = "UPDATE castings SET (movie_id, star_id, fee) = ($1, $2, $3) WHERE id = $4"
    values = [@movie_id, @star_id, @fee, @id]
    SqlRunner.run(sql, values)
  end


end
