def initialize_board
  board = {}
  (1..9).each {|position| board[position] = ' '}
  board
end

def empty_squares(curr_board)
  curr_board.select {|position, value| value == ' '}.keys
end

def player_pick(curr_board)
  puts "Please pick an empty square from 1 -9 (top left through bottom right)."
  position = gets.chomp.to_i
  until empty_squares(curr_board).include?(position)
    puts "That's not an option! Pick again."
    position = gets.chomp.to_i
    position
  end
  curr_board[position] = 'X'
end

def computer_pick(curr_board)
  position = empty_squares(curr_board).sample
  curr_board[position] = 'O'
end

def check_winner(curr_board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]]
  winning_lines.each do |line|
    return 'You Won!' if curr_board.values_at(*line).count('X') == 3
    return 'You lost!' if curr_board.values_at(*line).count('O') == 3
  end
  nil
end

def draw_board(curr_board)
  system 'clear'
  puts " #{curr_board[1]} | #{curr_board[2]} | #{curr_board[3]} "
  puts "____________"
  puts " #{curr_board[4]} | #{curr_board[5]} | #{curr_board[6]} "
  puts "____________"
  puts " #{curr_board[7]} | #{curr_board[8]} | #{curr_board[9]} "
end

puts "Let's play Tic-Tac-Toe. You take Xs. I'll take Os."
board = initialize_board
draw_board(board)
begin
  player_pick(board)
  draw_board(board)
  winner = check_winner(board)
  computer_pick(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_squares(board).empty?

if winner
  puts "#{winner}"
else
  puts "Tie!"
end