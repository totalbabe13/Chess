# require_relative('user_interface')

class Chess_game
  # include Ui_messages
	attr_accessor :board, :player_one, :player_two, :turn

	def initialize(p1,p2)
	    @player_one = [p1,['none captured']] #white
      @player_two = [p2,['none captured']] #black
      @turn       = "WHITE"
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
    player = ''
    
    if self.turn == "WHITE"
      player = player_one
    elsif self.turn == "BLACK"
      player = player_two
    end  
          

    system("clear")
    10.times { |i| puts " " }
    i = 0
    puts "It is now the #{turn} team's turn --> #{player} ITS YOUR MOVE!"
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
     move_piece(ask_player_to_select_piece,ask_player_to_choose_destination)

    # ask_player_to_select_piece
    # ask_player_to_choose_destination
	end	

  def ask_player_to_select_piece
    legal_move = false
    until legal_move != false
      puts " S E L E C T    T H E    P I E C E   Y O U   W A N T   T O   M O V E"
      puts "TYPE  the ROW (1-8) of the piece you want to move: and press ENTER"
      row = gets.chomp
      puts 'TYPE in the COLUMN (a - h / A - H) of the piece you want to move:  and press ENTER'
      column = gets.chomp
      from = [row,column]
      puts "- - - - -" 
      puts '' 
      player_input = find_player_input_coordinates(row,column)
      # - - - - check for empty cell- - - - - - 
       if  player_input == '-'
         puts ''
         puts "- - ERROR - -"
         puts "YOU HAVE NOT CHOSEN A PIECE TO MOVE-- CELL EMPTY"
         puts ''
         legal_move = false
       else 
         # - - - - - check if piece belogs to player ------
          if does_piece_belong_to_player(player_input) 
            legal_move = true
          else
            puts ''
            puts "- - ERROR - -"
            puts "YOU HAVE SELECTED A PIECE THAT IS NOT YOURS"
            puts ''
            legal_move = false
          end 
       end 
    end
    puts "You want to move your #{player_input} that is located at row: #{row} and column: #{column} "
    return from 
  end 

  def ask_player_to_choose_destination
    legal_move_to = false
    until legal_move_to != false
      puts ''
      puts " S E L E C T   W H E R E   Y O U   W A N T   T O   M O V E"
      puts "TYPE  the ROW (1-8) you want to move to: and press ENTER"
      row = gets.chomp
      puts 'TYPE in the COLUMN (a - h / A - H) you want to move to: and press ENTER'
      column = gets.chomp
      move_towards = [row,column] 
      puts ' - - - - -' 
      legal_move_to = find_player_input_coordinates(row,column)
    end
    puts "You want to move your piece to row: #{row} and column: #{column}: that is #{legal_move_to} "
    move_towards
  end 

  def move_piece(start,finish)
    from    = convert_user_input(start)
    towards = convert_user_input(finish)
    piece   = board[from[0]][from[1]]
    
    puts '---- testing possible moves 1 (inside #move_piece) ----'
    puts "from is  row-> #{from[0]} and column-> #{from[1]} }"
    puts "towards is #{towards}"
    check_possible_move_for(piece,from)

    board[from[0]][from[1]] = '-'
    board[towards[0]][towards[1]] = piece
  end 

  def change_player
    if self.turn == 'WHITE'
     self.turn = 'BLACK'
    else
     self.turn = 'WHITE'
    end      
  end  

  def convert_user_input(location)
    x = (location[0].to_i) - 1
    y = location[1]
    
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
    end 
    located = [x,y]
  end  

  def find_player_input_coordinates(x,y) 
    piece = ''
    x = x.to_i
    x = x-1
    if x > 8
     puts 'INVALID ENTRY' 
     return false
    elsif x < 0 
     puts 'INVALID ENTRY'
     return false
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
       puts "Error: INVALID entry"
       return false
    end
    piece = board[x][y]
  end

  def does_piece_belong_to_player(piece)
    black_pieces = ['♖','♘','♗','♕','♔','♙']
    white_pieces = ['♜','♞','♝','♛','♚','♟']

    if self.turn == "WHITE" &&  white_pieces.include?(piece)
      # puts "WHITE teams turn, with #{piece}"
      return true
    elsif self.turn == "BLACK" &&  black_pieces.include?(piece)
      # puts "BLACK teams turn, with #{piece}"
      return true
    else  
      # puts "test- 2 #{piece}"
      return false
    end
  end 

  def check_possible_move_for(piece,location)
    puts '---- testing possible moves 2 (inside #check_possible_move_for)----'
    moves = []
    x = location[0].to_i
    y = location[1].to_i

    # p x
    # p y

    case piece 
      when "♟"
        puts "this piece #{piece} is here #{location}"
        puts " row is #{x} and column is #{y} and it is a white pawn" # 6,1
        
        p cannot_move = [[x+1,y+1],[x+1,y],[x+1,y-1],[x, y-1],[x, y+1]]
             can_move = [[x-1,y-1],[x-1,y],[x-1,y+1]]
        if x == 6
          can_move << [x-2,y]
        end  
        puts "list of possible moves #{can_move}"
      end  

  end  

end #end of chess	
