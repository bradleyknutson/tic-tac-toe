require_relative "game"
require_relative "player"

def init
  game = Game.new

  puts "What is player 1's name?"
  player_1_name = gets.chomp
  puts "What is player 2's name?"
  player_2_name = gets.chomp

  players = [Player.new(player_1_name), Player.new(player_2_name)]
  active_player = 0
  until game.win? || game.tie?
    game.print
    puts "#{players[active_player].name}'s Turn"
    puts "Which space do you want to claim?"
    position = gets.chomp

    unless position.to_i.to_s == position
      puts "Needs to be a number"
      next
    end
    position = position.to_i
    
    unless position <= game.size ** 2 && position > 0
      puts "Needs to be a valid number on the board"
      next
    end

    unless game.not_taken?(position)
      puts "That square is taken"
      next
    end

    players[active_player].take_turn(game, position.to_i)
    active_player = 1 - active_player
  end
  game.end(players[1 - active_player])
  
end

init