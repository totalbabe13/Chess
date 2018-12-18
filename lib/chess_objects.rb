# require_relative('user_interface')

class Chess_game
  # include Ui_messages
	attr_accessor :board, :player_one, :player_two, :turn

	def initialize(p1,p2)
	    @player_one = [p1,['none captured']]
      @player_two = [p2,['none captured']]
      @turn = "WHITE"
      @board = [
        ['♖','♘','♗','♕','♔','♗','♘','♖'], #black
        ['♙','♙','♙','♙','♙','♙','♙','♙'], #black
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['♟','♟','♟','♟','♟','♟','♟','♟'], #white
        ['♜','♞','♝','♛','♚','♝','♞','♜']  #white
      ]
	end	

	def print_board
    system("clear")
    10.times { |i| puts " " }
    i = 0
    puts "It is now the #{turn} team's turn --> #{player_one[0]} ITS YOUR MOVE!"
    puts ''
    puts ''
    puts "PLAYER TWO: #{player_two[0]}"
    puts ''
    puts "     A   B   C   D   E   F   G   H"
    puts "   _________________________________"
    while i < board.length
      puts (i+1).to_s + ' |  ' + board[i].join(" | ") + " | "+ (i+1).to_s 
      i += 1
    end
    puts "   _________________________________"
    puts ''
    puts "     A   B   C   D   E   F   G   H"
    puts ''
    puts "PLAYER ONE: #{player_one[0]}"
    2.times { |i| puts " " } 
    ask_player_to_select_piece
    ask_player_to_choose_destination
	end	

  def ask_player_to_select_piece
    puts "TYPE  the ROW (1-8) of the piece you want to move: and press ENTER"
    row = gets.chomp
    puts 'TYPE in the COLUMN (a - h / A - H) of the piece you want to move:  and press ENTER'
    column = gets.chomp
    puts "- - - - -" 
    puts '' 
    piece = find_player_input_coordinates(row,column)
    puts "You want to move your #{piece} that is located at row: #{row} and column: #{column} "
  end 

  def ask_player_to_choose_destination
    puts "TYPE  the ROW (1-8) you want to move to: and press ENTER"
    row = gets.chomp
    puts 'TYPE in the COLUMN (a - h / A - H) you want to move to: and press ENTER'
    column = gets.chomp
    puts "- - - - -" 
    puts '' 
    new_spot = find_player_input_coordinates(row,column)
    puts "You want to move your piece to row: #{row} and column: #{column}: that is #{new_spot} "
  end 

  def move_piece(r,c)
   
  end  

  def find_player_input_coordinates(x,y)
    x = x.to_i
    x = x-1
    if x > 8
      puts "invalid ROW entry"
    elsif x < 0 
      puts "invalid ROW entry"
    end
    
    case y
      when 'a' || 'A'
       y = 0
      when 'b' || 'B'
       y = 1
      when 'c' || 'C'
       y = 2 
      when 'd' || 'D'
       y = 3
      when 'e' || 'E'
       y = 4 
      when 'f' || 'F'
       y = 5
      when 'g' || 'G'
       y = 6 
      when 'h' || 'H'
       y = 7 
      else
      "Error: INVALID COLUMN entry"
    end
    if board[x][y] != '-'
      p board[x][y]
    else 
      p 'Available spot'
    end
    start = board[x][y] 
    return start  
  end

end	

# class PLayer
#   def initialize
# end  

