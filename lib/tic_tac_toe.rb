def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(p_move)
  return p_move.to_i - 1
end

def move(board, p_move, x_or_o)
  board[p_move] = x_or_o
end

def position_taken?(board,index)
  return !(board[index] == " " || board[index] == "" || board[index] == nil)
  return (board[index] == "X" || board[index] == "O")
end

def valid_move?(board,move)
  return (move >= 0 && move <= 8 && !position_taken?(board,move))
end

def turn(board)
  puts "Player #{current_player(board)}, Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board,index)
    if position_taken?(board,index)
      puts "Sorry, that position is taken, please select another."
    else
      puts "Sorry, that is not a valid move. Please select a number 1 through 9."
    end
    input = gets.strip
    index = input_to_index(input)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if move == "X" || move == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def won?(board)
  WIN_COMBINATIONS.each do |win_move|
    if win_move.all? {|space| board[space] == "X"} || win_move.all? {|space| board[space] == "O"}
      return win_move
      break
    end
  end
  return false
end

def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  if !won?(board)
    return full?(board)
  else
    return false
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) == false
    return nil
  else
    WIN_COMBINATIONS.each do |win_move|
      if win_move.all? {|space| board[space] == "X"}
        return "X"
        elsif win_move.all? {|space| board[space] == "O"}
        return "O"
      end
    end
  end
end