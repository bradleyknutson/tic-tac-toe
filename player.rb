class Player
  attr_reader :name
  @@player_num = 0
  def initialize(name)
    @@player_num += 1
    @name = name
    @symbol = @@player_num == 1 ? "X" : "O"
  end

  def take_turn(game, placement)
    game.move(placement, @symbol)
  end
end