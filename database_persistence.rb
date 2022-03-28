require "pg"
require "pry"

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "goals")
  end

  def all_goals
    sql = "SELECT * FROM goals;"
    results = @db.exec_params(sql);

    results.map do |tuple|
      { id: tuple["id"].to_i,
        name: tuple["goal_name"],
        amount: tuple["goal_amount"].to_f,
        private: tuple["goal_private"] == 't',
        creator_id: tuple["creator_id"] }
    end
  end

  def create_goal(data)
    sql = <<~SQL
      INSERT INTO goals (goal_name, goal_amount, goal_private, creator_id)
      VALUES ($1, $2, $3, $4);
    SQL
    name = data["goal_name"]
    amount = data["goal_amount"].to_f
    is_private = data["goal_private"]
    creator_id = data["creator_id"].to_i

    @db.exec_params(sql, [name, amount, is_private, creator_id])
  end
end