# require_relative('user_interface')

class Chess_game
  # include Ui_messages
	attr_accessor :board, :player_one, :player_two, :turn

	def initialize(p1,p2)
	    @player_one = [p1,[]] #white
      @player_two = [p2,[]] #black
      @turn       = "BLACK"
      @board = [
        ['♖','♘','♗','♕','♔','♗','♘','♖'], #black
        ['♙','♙','♙','♙','♙','♙','♙','♙'], #black
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','♖','-','-','-','-'],
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
    puts "It is now the #{turn} team's turn --> #{player[0]} ITS YOUR MOVE!"
    puts ''
    puts ''
    puts "PLAYER TWO: #{player_two[0]} captured pieces : #{player_two[1]}"
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
    puts "PLAYER ONE: #{player_one[0]}, captured pieces : #{player_one[1]}"
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
    other_piece = board[towards[0]][towards[1]]
    
    puts '---- testing possible moves 1 (inside #move_piece) ----'
    puts "from is  row-> #{from[0]} and column-> #{from[1]} }"
    puts "towards is #{towards}"
    puts "find piece if trying to capture #{board[towards[0]][towards[1]]}"
    #check_possible_move_for(piece,from,towards)

     if check_possible_move_for(piece,from,towards).include?(towards)
      puts "TEST 3 - after #checking_for_possible moves -"

      if other_piece != '-' && self.turn == "WHITE"
        self.player_one[1] << other_piece
      end

      if other_piece != '-' && self.turn == "BLACK"
        self.player_two[1] << other_piece
      end

      board[from[0]][from[1]] = '-'
      board[towards[0]][towards[1]] = piece
    else
      puts "this move is ILLEGAL ERROR"  
    end  

    # board[from[0]][from[1]] = '-'
    # board[towards[0]][towards[1]] = piece
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

  def check_possible_move_for(piece,location,destination)
    puts '---- testing possible moves 2 (inside #check_possible_move_for)----'
    black_pieces = ['♖','♘','♗','♕','♔','♙']
    white_pieces = ['♜','♞','♝','♛','♚','♟']

    x = location[0].to_i
    y = location[1].to_i


    x_to = destination[0].to_i
    y_to = destination[1].to_i
    value_of_destination_cell = board[x_to][y_to]
    
   

    # p x
    # p y

    case piece 
 # - - - - - - - WHITE PAWN - - - - - - - -     
      when "♟"
        puts "this piece #{piece} is here #{location}"
        puts " row is #{x} and column is #{y} and it is a white pawn" # 6,1
        can_move  = []#[[x-1,y]]
        capture   = [[x-1,y-1],[x-1,y+1]]
        capturing = [board[x-1][y-1],board[x-1][y+1]]

        
        if board[x-1][y] == '-'
          can_move << [x-1,y]
        end
          
        if x == 6 && board[x-1][y] == '-' && board[x-2][y] == '-'
          can_move << [x-2,y]
        end  
        
        if black_pieces.include?(capturing[0]) 
          can_move << capture[0]
        end  
        if black_pieces.include?(capturing[1]) 
          can_move << capture[1]  
        end  

        if can_move.empty?
          puts "NO LEGAL MOVES"
        end  

        puts "list of possible moves -->#{can_move}"
        # puts "list of illegal moves --> #{cannot_move}"
        return can_move
 # - - - - - - - WHITE PAWN - - - - - - - -

 # - - - - - - - BLACK PAWN - - - - - - - -
      when "♙"
        puts "this piece #{piece} is here #{location}"
        puts "row is #{x} and column is #{y} and it is a black pawn" # 6,1
        can_move  = []#[[x-1,y]]
        capture   = [[x+1,y-1],[x+1,y+1]]
        capturing = [board[x+1][y-1],board[x+1][y+1]]

        if board[x+1][y] == '-'
          can_move << [x+1,y]
        end
          
        if x == 1 && board[x+1][y] == '-' && board[x+2][y] == '-'
          can_move << [x+2,y]
        end  
        
        if white_pieces.include?(capturing[0]) 
          can_move << capture[0]
        end  
        if white_pieces.include?(capturing[1]) 
          can_move << capture[1]  
        end  

        if can_move.empty?
          puts "NO LEGAL MOVES"
        end  

        puts "list of possible moves -->#{can_move}"
        # puts "list of illegal moves --> #{cannot_move}"
        return can_move
  # - - - - - - - BLACK PAWN - - - - - - - -

  # - - - - - - - WHITE ROOK - - - - - - - -
       when "♜"
        can_move  = []
        horizontal  = board[x]     
        
         #MAPING ROW TO THE LEFT
         left_move = y-1
         while left_move > -1
          if horizontal[left_move] == '-'
            can_move << [x,left_move]
          end

          if black_pieces.include?(horizontal[left_move])
            can_move << [x,left_move]
            break if black_pieces.include?(horizontal[left_move])
          end 
          break if white_pieces.include?(horizontal[left_move]) 
          left_move -= 1
         end 
       
         #MAPING ROW TO THE RIGHT
         right_move = y+1
         while right_move < 8
          
          if horizontal[right_move] == '-'
            can_move << [x,right_move]
          end

          if black_pieces.include?(horizontal[right_move])
            can_move << [x,right_move]
            break if black_pieces.include?(horizontal[right_move])
          end 
          break if white_pieces.include?(horizontal[right_move]) 
          right_move += 1
         end 
        
         #MAPING COLUMN FOWRWARD
          forward_move = x+1
          while forward_move < 8
                                            
            if board[forward_move][y] == '-'
              can_move << [forward_move,y]
            end

            if black_pieces.include?(board[forward_move][y])
              can_move << [forward_move,y]
              break if black_pieces.include?(board[forward_move][y])
            end

            break if white_pieces.include?(board[forward_move][y])
            forward_move += 1
          end 

          #MAPING COLUMN BACKWARD
          backward_move = x-1
          while backward_move > -1
                                           
            if board[backward_move][y] == '-'
              can_move << [backward_move,y]
            end

            if black_pieces.include?(board[backward_move][y])
              can_move << [backward_move,y]
              break if black_pieces.include?(board[backward_move][y])
            end

            break if white_pieces.include?(board[backward_move][y])
            backward_move -= 1
          end 
       


  # - - - - - - - WHITE ROOK - - - - - - - -

  # - - - - - - - BLACK ROOK - - - - - - - -

when "♖"
        can_move  = []
        horizontal  = board[x]     
        
         #MAPING ROW TO THE LEFT
         left_move = y-1
         while left_move > -1
          if horizontal[left_move] == '-'
            can_move << [x,left_move]
          end

          if white_pieces.include?(horizontal[left_move])
            can_move << [x,left_move]
            break if white_pieces.include?(horizontal[left_move])
          end 
          break if black_pieces.include?(horizontal[left_move]) 
          left_move -= 1
         end 
       
         #MAPING ROW TO THE RIGHT
         right_move = y+1
         while right_move < 8
          
          if horizontal[right_move] == '-'
            can_move << [x,right_move]
          end

          if white_pieces.include?(horizontal[right_move])
            can_move << [x,right_move]
            break if white_pieces.include?(horizontal[right_move])
          end 
          break if black_pieces.include?(horizontal[right_move]) 
          right_move += 1
         end 
        
         #MAPING COLUMN FOWRWARD
          forward_move = x+1
          while forward_move < 8
                                            
            if board[forward_move][y] == '-'
              can_move << [forward_move,y]
            end

            if white_pieces.include?(board[forward_move][y])
              can_move << [forward_move,y]
              break if white_pieces.include?(board[forward_move][y])
            end

            break if black_pieces.include?(board[forward_move][y])
            forward_move += 1
          end 

          #MAPING COLUMN BACKWARD
          backward_move = x-1
          while backward_move > -1
                                           
            if board[backward_move][y] == '-'
              can_move << [backward_move,y]
            end

            if white_pieces.include?(board[backward_move][y])
              can_move << [backward_move,y]
              break if white_pieces.include?(board[backward_move][y])
            end

            break if black_pieces.include?(board[backward_move][y])
            backward_move -= 1
          end 
         puts "can move array --> #{can_move}"

  # - - - - - - - BLACK ROOK - - - - - - - -
        
      end  

  end  

end #end of chess	
