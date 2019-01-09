# require_relative('user_interface')

class Chess_game
  # include Ui_messages
	attr_accessor :board, :player_one, :player_two, :turn, :check_mate, :check 

	def initialize(p1,p2)
	    @player_one = [p1,[],false] #white
      @player_two = [p2,[],false] #black
      @turn       = "WHITE" # "BLACK" or "WHITE"
      @check = false
      @check_mate = false
      @board = [
        ['♖','♘','♙','♕','♔','♗','♘','♖'], #black
        ['♙','♙','♙','♙','♙','♙','♙','♙'], #black
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','♚','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','♜','-'],
        ['-','-','-','-','-','-','-','♜'], #white
        ['-','-','-','♔','-','-','-','-']  #white
      ]

      # [
      #   ['♖','♘','♙','♕','♔','♗','♘','♖'], #black
      #   ['♙','♙','♙','♙','♙','♙','♙','♙'], #black
      #   ['-','-','-','-','-','-','-','-'],
      #   ['-','-','-','♚','-','-','-','-'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['♟','♟','♟','♟','♟','♟','♟','♟'], #white
      #   ['♜','♞','♝','♛','-','♝','♞','♜']  #white
      # ]
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

    if is_current_player_in_check == true

      if self.turn == "WHITE"
        puts " W - A - R - N - I - N - G!!"
        puts "#{player_two[0]} has put you in C-H-E-C-K-!!!"
        puts ''
        puts ' - - - - - - - - - - - - - - - - - - - - - - - '
      end

      if self.turn == "BLACK"
        puts " W - A - R - N - I - N - G!!"
        puts "#{player_one[0]} has put you in C-H-E-C-K-!!!"
        puts ''
        puts ' - - - - - - - - - - - - - - - - - - - - - - - '
      end

    end  

    i = 0
    puts "It is now the #{turn} team's turn --> #{player[0]} ITS YOUR MOVE!"
    puts ''
    puts ''
    puts "PLAYER TWO: #{player_two[0]} -- Captured pieces : #{player_two[1]} -- IN CHECK?-> #{player_two[2].to_s}"
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
    puts "PLAYER ONE: #{player_one[0]} -- captured pieces : #{player_one[1]} -- IN CHECK?-> #{player_one[2].to_s}"
    2.times { |i| puts " " } 

    legal = false 
    while legal == false
      if move_piece(ask_player_to_select_piece,ask_player_to_choose_destination)
        legal = true
      end 
    end   
    # ask_player_to_select_piece
    # ask_player_to_choose_destination
	end	

  def ask_player_to_select_piece
    legal_move = false
    until legal_move != false
      puts " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      puts " S E L E C T    T H E    P I E C E   Y O U   W A N T   T O   M O V E"
      puts "TYPE the ROW (1-8): and press ENTER"
      row = gets.chomp
      puts 'TYPE the COLUMN (a - h / A - H):  and press ENTER'
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
  
  def is_current_player_in_check
    if self.turn == "WHITE"
      return player_one[2]
    end 

    if self.turn == "BLACK"
     return player_two[2]
    end   
    
  end  

  def move_piece(start,finish)
    from    = convert_user_input(start)
    towards = convert_user_input(finish)
    piece   = board[from[0]][from[1]]
    other_piece = board[towards[0]][towards[1]]

     
  # 1. Ask if player is in CHECK? if yes --> proceed through normal move mechanism  
    # if is_current_player_in_check == false

    if is_current_player_in_check == true
      puts "current player is in check"

      #1a. UPDATE the board temporarily 
      board[from[0]][from[1]] = '-'
      board[towards[0]][towards[1]] = piece
      #1b. Map opposite players potential captures
      other_players_moves = []
      opposite_pawns = []
      opp_pawn_move = []
      
      #- - - - FOR BLACK - - - - - - - 
      if self.turn == "BLACK" 
      #1c. Mapping pawn captures
      find_all_opposite_players_pieces.each do |item|
        if item[0] == '♟'
          opposite_pawns << item[1]
        end  
      end  
      opposite_pawns.each do |pawn|  
          if pawn[0] > 0 && pawn[1] > 0  
            if board[pawn[0] - 1][pawn[1] - 1] == '-' 
              opp_pawn_move << [pawn[0] - 1, pawn[1] - 1]
            end   
          end

          if pawn[0] > 0 && pawn[1] < 7
            if board[pawn[0] - 1][pawn[1] + 1] == '-' 
              opp_pawn_move << [pawn[0] - 1, pawn[1] + 1]
            end   
          end
      end
      opp_pawn_move.uniq!
     # puts "opposite pawns moves --> #{opp_pawn_move}" #WORKS!
      
      #1d. REMOVE PAWNS from all pieces // Map othe pieces captures
      find_all_opposite_players_pieces.each do |item|
        if item[0] != '♟'
          if check_possible_move_for(item[0],item[1],['inv','inv']) != []
             other_players_moves << check_possible_move_for(item[0],item[1],['inv','inv'])
          end 
        end  
      end
      other_players_moves << opp_pawn_move  
      other_players_moves.flatten!(1)
      other_players_moves.uniq!
     #1e. CHECK IF KING WILL BE IN CHECK still 
      if other_players_moves.include?(find_current_players_king[1]) == false
        player_two[2] = false
        puts "king not in check!"
        return true
      else 
        board[from[0]][from[1]] = piece  
        board[towards[0]][towards[1]] = other_piece 
        puts "ILLEGAL MOVE!! CANNOT MOVE KING INTO CHECK!"
        return false 
      end  
    end #(end of BLACK // CHECK)

    # - - - -FOR WHITE - - - - - - - - 
    if self.turn == "WHITE"
        #1c. Mapping pawn captures
      find_all_opposite_players_pieces.each do |item|
        if item[0] == '♙'
          opposite_pawns << item[1]
        end  
      end  
      opposite_pawns.each do |pawn|  
          if pawn[0] < 7 && pawn[1] < 7  
            if board[pawn[1][0] + 1][pawn[1][1] + 1] == '-' 
               opp_pawn_move << [pawn[0] + 1, pawn[1] + 1]
            end   
          end
          if pawn[0] < 7 && pawn[1] > 0
            if board[pawn[1][0] + 1][pawn[1][1] - 1] == '-' 
               opp_pawn_move << [pawn[0] + 1, pawn[1] - 1]
            end   
          end
      end
      opp_pawn_move.uniq!
     # puts "opposite pawns moves --> #{opp_pawn_move}" #WORKS!
      
      #1d. REMOVE PAWNS from all pieces // Map othe pieces captures
      find_all_opposite_players_pieces.each do |item|
        if item[0] != '♙'
          if check_possible_move_for(item[0],item[1],['inv','inv']) != []
             other_players_moves << check_possible_move_for(item[0],item[1],['inv','inv'])
          end 
        end  
      end
      other_players_moves << opp_pawn_move  
      other_players_moves.flatten!(1)
      other_players_moves.uniq!
     #1e. CHECK IS KING WILL BE IN CHECK still 
      if other_players_moves.include?(find_current_players_king[1]) == false
        player_two[2] = false
        puts "king not in check!"
        return true
      else 
        board[from[0]][from[1]] = piece  
        board[towards[0]][towards[1]] = other_piece 
        puts "ILLEGAL MOVE!! CANNOT MOVE KING INTO CHECK!"
        return false 
      end  
    end #(END OF WHITE)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      

    elsif is_current_player_in_check == false
      puts "current player is not in check"
        

     # 2. Ask if current player can legally move to thier selected destination
    if check_possible_move_for(piece,from,towards).include?(towards)
      
      # 3. Ask if Current player's selected piece going to put other player's King into check?
      if check_possible_move_for(piece,towards,['inv','inv']).include?(find_other_players_king[1])
        if turn == "WHITE"
          player_two[2] = true
        end 

        if turn == "BLACK"
          player_one[2] = true
        end     
      end 
                               
      #4. CAPTURE MECHANISM HERE v
      if other_piece != '-' && self.turn == "WHITE"
        self.player_one[1] << other_piece
      end

      if other_piece != '-' && self.turn == "BLACK"
        self.player_two[1] << other_piece
      end

      #5. UPDATE the board // MOVE the piece
      board[from[0]][from[1]] = '-'
      board[towards[0]][towards[1]] = piece

      #6. Ask if current players move will open any other pieces to put other player in check
      future_moves = []
          #6a. Make map of current players pieces, and thier future captures
      find_all_current_players_pieces.each do |item|
        if item != [piece,from]
          if check_possible_move_for(item[0],item[1],['inv','inv']) != []
            future_moves << check_possible_move_for(item[0],item[1],['inv','inv'])
          end 
        end  
      end 
        #6b. Ask if other player's King position is with in range of any of current player's move matrix
      if future_moves.flatten!(1).include?(find_other_players_king[1])
          if turn == "WHITE"
            player_two[2] = true
          end 

          if turn == "BLACK"
            player_one[2] = true
          end   
      end #(end for step #2)
      #7. return true to #PRINT BOARD, to update the board
      return true 
       
     else
        puts ''
        puts ''
        puts "ERROR:: ILLEGAL MOVE"
        puts "re-enter coordinates"
        return false  
     end   
    end #if player not in check (end for step #1)
  end 

  def find_all_current_players_pieces
    current_player_pieces = []
    
    if self.turn == "WHITE"
      white_pieces = ['♜','♞','♝','♛','♟','♚']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if white_pieces.include?(obj[0]) 
              current_player_pieces << obj
            end 
            j+=1
          end
          i += 1
        end
        return current_player_pieces
    end

    if self.turn == "BLACK"
      black_pieces = ['♖','♘','♗','♕','♔','♙']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if black_pieces.include?(obj[0]) 
              current_player_pieces << obj
            end 
            j+=1
          end
          i += 1
        end
        return current_player_pieces
    end
  end  

  def find_all_opposite_players_pieces
    current_player_pieces = []
    
    if self.turn == "BLACK"
      white_pieces = ['♜','♞','♝','♛','♟','♚']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if white_pieces.include?(obj[0]) 
              current_player_pieces << obj
            end 
            j+=1
          end
          i += 1
        end
        return current_player_pieces
    end

    if self.turn == "WHITE"
      black_pieces = ['♖','♘','♗','♕','♔','♙']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if black_pieces.include?(obj[0]) 
              current_player_pieces << obj
            end 
            j+=1
          end
          i += 1
        end
        return current_player_pieces
    end
  end   

  def find_current_players_king
    other_king = 'empty'
   
    if self.turn == "BLACK"
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if obj[0] == '♔'
              other_king = obj
            end  
            j+=1
          end
          i += 1
        end
    end
        
    if self.turn == "WHITE"
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if obj[0] == '♚'
              other_king = obj
            end  
            j+=1
          end
          i += 1
        end
    end
    #puts "INSIDE other players king function --> #{other_king}"        
    return other_king           
  end

  def find_other_players_king
    other_king = 'empty'
   
    if self.turn == "WHITE"
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if obj[0] == '♔'
              other_king = obj
            end  
            j+=1
          end
          i += 1
        end
    end
        
    if self.turn == "BLACK"
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if obj[0] == '♚'
              other_king = obj
            end  
            j+=1
          end
          i += 1
        end
    end
    #puts "INSIDE other players king function --> #{other_king}"        
    return other_king           
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
    #puts '----(inside #check_possible_move_for)----'
    black_pieces = ['♖','♘','♗','♕','♔','♙']
    white_pieces = ['♜','♞','♝','♛','♚','♟']
    x = location[0].to_i
    y = location[1].to_i
    x_to = destination[0].to_i
    y_to = destination[1].to_i
    value_of_destination_cell = board[x_to][y_to]
    
    case piece 
  # - - - - - - - WHITE PAWN - - - - - - - -     
      when "♟"
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
          # puts "NO LEGAL MOVES"
        end  

        # puts "list of possible moves -->#{can_move}"
        return can_move
  # - - - - - - - WHITE PAWN - - - - - - - -
  # - - - - - - - BLACK PAWN - - - - - - - -
      when "♙"
        # puts "this piece #{piece} is here #{location}"
        # puts "row is #{x} and column is #{y} and it is a black pawn" # 6,1
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
          # puts "NO LEGAL MOVES"
        end  

        # puts "list of possible moves -->#{can_move}"
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
          return can_move 
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
          return can_move
  # - - - - - - - BLACK ROOK - - - - - - - -
  # - - - - - - - WHITE BISHOP - - - - - - - -
      when "♝"
          can_move  = []

          #MAPING Diagonal  x+1, y+1
          diagonal_1 = [x+1,y+1]
          while diagonal_1[0] < 8 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] += 1
            
          end  

          #MAPING Diagonal  x-1, y-1
          diagonal_1 = [x-1,y-1]
          while diagonal_1[0] > -1 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] -= 1
            
          end  

          #MAPING Diagonal  x+1, y-1
          diagonal_1 = [x+1,y-1]
          while diagonal_1[0] < 8 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] -= 1
            
          end

          # #MAPING Diagonal  x-1, y+1
          diagonal_1 = [x-1,y+1]
          while diagonal_1[0] > -1 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] += 1
          end          
          return can_move
  # - - - - - - - WHITE BISHOP - - - - - - - -
  # - - - - - - - BLACK BISHOP - - - - - - - -
      when "♗"
          can_move  = []

          #MAPING Diagonal  x+1, y+1
          diagonal_1 = [x+1,y+1]
          while diagonal_1[0] < 8 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] += 1
            
          end  

          #MAPING Diagonal  x-1, y-1
          diagonal_1 = [x-1,y-1]
          while diagonal_1[0] > -1 && diagonal_1[1]  > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] -= 1
            
          end  

          #MAPING Diagonal  x+1, y-1
          diagonal_1 = [x+1,y-1]
          while diagonal_1[0] < 8 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] -= 1
            
          end

          # #MAPING Diagonal  x-1, y+1
          diagonal_1 = [x-1,y+1]
          while diagonal_1[0] > -1 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] += 1
          end 
          return can_move
          #puts "all moves --> #{can_move}"     
  # - - - - - - - BLACK BISHOP - - - - - - - -
  # - - - - - - - WHITE KNIGHT - - - - - - - -
      when "♞"
          can_move  = []
          moves = [[x+1,y+2],[x-1,y+2],[x-1,y-2],[x+1,y-2],[x+2,y+1],[x+2,y-1],[x-2,y+1],[x-2,y-1]]
          moves.delete_if { |place| place[0] < 0 || place[0] > 7 }
          moves.delete_if { |place| place[1] < 0 || place[1] > 7 }

          moves.each do |move|
            if board[move[0]][move[1]] == '-'
              can_move << move 
            end 

            if black_pieces.include?(board[move[0]][move[1]])
              can_move << move   
            end
          end 
          return can_move    
          #puts "knight moves --> #{can_move}"
  # - - - - - - - WHITE KNIGHT - - - - - - - -
  # - - - - - - - BLACK KNIGHT - - - - - - - -
      when "♘"
          can_move  = []
          moves = [[x+1,y+2],[x-1,y+2],[x-1,y-2],[x+1,y-2],[x+2,y+1],[x+2,y-1],[x-2,y+1],[x-2,y-1]]
          moves.delete_if { |place| place[0] < 0 || place[0] > 7 }
          moves.delete_if { |place| place[1] < 0 || place[1] > 7 }

          moves.each do |move|
            if board[move[0]][move[1]] == '-'
              can_move << move 
            end 

            if white_pieces.include?(board[move[0]][move[1]])
              can_move << move   
            end
          end
          return can_move         
  # - - - - - - - BLACK KNIGHT - - - - - - - -
  # - - - - - - - WHITE QUEEN - - - - - - - -
      when "♛"
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

           #MAPING Diagonal  x+1, y+1
          diagonal_1 = [x+1,y+1]
          while diagonal_1[0] < 8 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] += 1
            
          end  

          #MAPING Diagonal  x-1, y-1
          diagonal_1 = [x-1,y-1]
          while diagonal_1[0] > -1 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] -= 1
            
          end  

          #MAPING Diagonal  x+1, y-1
          diagonal_1 = [x+1,y-1]
          while diagonal_1[0] < 8 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] -= 1
            
          end

          # #MAPING Diagonal  x-1, y+1
          diagonal_1 = [x-1,y+1]
          while diagonal_1[0] > -1 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] += 1
          end
          return can_move 
  # - - - - - - - WHITE QUEEN - - - - - - - -
  # - - - - - - - BLACK QUEEN - - - - - - - -
      when "♕"
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

           #MAPING Diagonal  x+1, y+1
          diagonal_1 = [x+1,y+1]
          while diagonal_1[0] < 8 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] += 1
            
          end  

          #MAPING Diagonal  x-1, y-1
          diagonal_1 = [x-1,y-1]
          while diagonal_1[0] > -1 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] -= 1
            
          end  

          #MAPING Diagonal  x+1, y-1
          diagonal_1 = [x+1,y-1]
          while diagonal_1[0] < 8 && diagonal_1[1] > -1
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] += 1
            diagonal_1[1] -= 1
            
          end

          # #MAPING Diagonal  x-1, y+1
          diagonal_1 = [x-1,y+1]
          while diagonal_1[0] > -1 && diagonal_1[1] < 8
            
            if board[diagonal_1[0]][diagonal_1[1]] == '-'
              can_move <<[ diagonal_1[0], diagonal_1[1] ]
            end
            
            if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
              can_move << [ diagonal_1[0], diagonal_1[1] ]
              break if white_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])
            end

            break if black_pieces.include?(board[diagonal_1[0]][diagonal_1[1]])

            diagonal_1[0] -= 1
            diagonal_1[1] += 1
            
          end
          return can_move
          #puts "all moves --> #{can_move}"
  # - - - - - - - BLACK QUEEN - - - - - - - -        
  # - - - - - - - WHITE KING - - - - - - - -
      when "♚"
        other_black_pieces = ['♖','♘','♗','♕']
        king_moves = [[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
        look_for_check_mate = []
        pawns = []
        other_king = []
        king_cannot_move = []
        legal_moves = []
        all_moves = []

        i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if obj[0] == '♙'
              pawns << obj
            end 

            if obj[0] == '♔'
              other_king << obj
            end  

            if other_black_pieces.include?(board[i][j])
              look_for_check_mate << obj
            end
            j+=1
          end
          i += 1
        end       
        
        pawn_move =[]
        pawns.each do |pawn|  
          if pawn[1][0] < 7 && pawn[1][1] < 7  
            if board[pawn[1][0] + 1][pawn[1][1] + 1] == '-' 
               pawn_move << [pawn[1][0] + 1, pawn[1][1] + 1]
            end   
          end
          if pawn[1][0] < 7 && pawn[1][1] > 0
            if board[pawn[1][0] + 1][pawn[1][1] - 1] == '-' 
               pawn_move << [pawn[1][0] + 1, pawn[1][1] - 1]
            end   
          end

        end
        king_cannot_move << pawn_move.uniq!

        look_for_check_mate.each do |item|
          piece_obj = check_possible_move_for(item[0],item[1],['inv','inv'])
            if piece_obj != []
              king_cannot_move << piece_obj
            end  
        end

        other_king.flatten!(1)
        a = other_king[1][0] #row
        b = other_king[1][1] #column
        move_map_other_king = [[a,b-1],[a+1,b-1],[a+1,b],[a+1,b+1],[a,b+1],[a-1,b+1],[a-1,b],[a-1,b-1]]
        move_map_other_king.delete_if do |item|
          ((0..7) === item[0] && (0..7) === item[1]) == false     
        end

        king_cannot_move << move_map_other_king    
        king_cannot_move.flatten!(1)
        king_cannot_move.uniq!

        king_moves.each do |move|
          if (0..7) === move[0] && (0..7) === move[1]
            if white_pieces.include?(board[move[0]][move[1]]) == false
              legal_moves << move 
            end  
          end     
        end 
        legal_moves.map! do |move|
          if (king_cannot_move.include?(move)) == false
            all_moves << move
          end  
        end 
        #puts "all moves -> #{all_moves}"
        return all_moves
  # - - - - - - - WHITE KING - - - - - - - -
  # - - - - - - - BLACK KING - - - - - - - -
      when "♔"
        other_white_pieces = ['♜','♞','♝','♛']
        king_moves = [[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
        look_for_check_mate = []
        pawns = []
        other_king = []
        other_king_moves = []
        king_cannot_move = []
        legal_moves = []
        all_moves = []
        #MAPPING all pieces that belong to other player
        i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            #PAWNS get dealt with separatly 
            if obj[0] == '♟'
              pawns << obj
            end 
            #Cannot check/ check mate other king
            if obj[0] == '♚'
              other_king << obj
            end  
            #all other pieces can be gropuped in seprate array
            if other_white_pieces.include?(board[i][j])
              look_for_check_mate << obj
            end
            j+=1
          end
          i += 1
        end           
        #plotting all potential capture moves for other player's pawns
        pawn_move =[]
        pawns.each do |pawn|  
          if pawn[1][0] > 0 && pawn[1][1] > 0  
            if board[pawn[1][0] - 1][pawn[1][1] - 1] == '-' 
              pawn_move << [pawn[1][0] - 1, pawn[1][1] - 1]
            end   
          end

          if pawn[1][0] > 0 && pawn[1][1] < 7
            if board[pawn[1][0] - 1][pawn[1][1] + 1] == '-' 
              pawn_move << [pawn[1][0] - 1, pawn[1][1] + 1]
            end   
          end
        end
        king_cannot_move << pawn_move.uniq!
        
        look_for_check_mate.each do |item|
          piece_obj = check_possible_move_for(item[0],item[1],['inv','inv']) 
          if piece_obj != []
            king_cannot_move << piece_obj
          end  
        end 

        other_king.flatten!(1)
        a = other_king[1][0]
        b = other_king[1][1]
        move_map_other_king = [[a,b-1],[a+1,b-1],[a+1,b],[a+1,b+1],[a,b+1],[a-1,b+1],[a-1,b],[a-1,b-1]]
        move_map_other_king.delete_if do |item|
          ((0..7) === item[0] && (0..7) === item[1]) == false     
        end
        king_cannot_move << move_map_other_king    
        king_cannot_move.flatten!(1)
        king_cannot_move.uniq!
    
        king_moves.each do |move|
          if (0..7) === move[0] && (0..7) === move[1]
            if black_pieces.include?(board[move[0]][move[1]]) == false
          legal_moves << move 
            end  
          end     
        end 

        legal_moves.map! do |move|
          if (king_cannot_move.include?(move)) == false
            all_moves << move
          end  
        end
        #puts "all_moves --> #{all_moves} "
        return all_moves
  # - - - - - - - BLACK KING - - - - - - - -
      end#end of case  
  end #end of check_possible_moves 

end #end of chess	
