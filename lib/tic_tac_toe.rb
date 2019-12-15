WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, position, player_toaken)
  board[position] = player_toaken
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    return true
  else
    return false
  end
end

def valid_move?(board, position)
  if !position.between?(0, 8) || position_taken?(board,position)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9 to make a move."
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, "X")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |index|
    if index == "X" || index == "O"
      turns += 1
    end
  end
  return turns
end
#15
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    position_taken?(board, combo[0]) &&
    board[combo[0]] == board[combo[1]] &&
    board[combo[0]] == board[combo[2]]
  end
end

def full?(board)
  if turn_count(board) == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    false
  end
end

def winner(board)
  if !won?(board)
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
    move(board, input_to_index(board), current_player(board))
    over?(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}you won the game!"
  else
    puts "Cat's Game!"
  end
end
