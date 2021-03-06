
require_relative("save_or_load")
require_relative("user_interface")
require "pry"

class Chess_game
   include Game_data_functions
   include Ui_messages
	attr_accessor :board, :player_one, :player_two, :turn, :check_mate, :check 

	def initialize(p1,p2, turn= "WHITE", check_mate= false, board= [['♖','♘','♗','♔','♕','♗','♘','♖'],['♙','♙','♙','♙','♙','♙','♙','♙'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['♟','♟','♟','♟','♟','♟','♟','♟'],['♜','♞','♝','♚','♛','♝','♞','♜']])
	    @player_one = [p1,[],false] 
      @player_two = [p2,[],false] 
      @turn       = turn 
      @check_mate = check_mate
      @board = board
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
    puts "CHECK MATE? #{self.check_mate}"
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
	end	

  def ask_player_to_select_piece
    legal_move = false
    until legal_move != false
      puts " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      puts " S E L E C T    T H E    P I E C E   Y O U   W A N T   T O   M O V E"
      puts "TYPE the ROW (1-8): and press ENTER"
      row = gets.chomp
      puts 'TYPE the COLUMN (a - h):  and press ENTER'
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
    puts "SELECTED PIECE #{player_input} -->  #{row},#{column} "
    return from 
  end 

  def ask_player_to_choose_destination
    legal_move_to = false
    until legal_move_to != false
      puts ''
      puts " S E L E C T   W H E R E   Y O U   W A N T   T O   M O V E"
      puts "TYPE  the ROW (1-8): and press ENTER"
      row = gets.chomp
      puts 'TYPE in the COLUMN (a - h): and press ENTER'
      column = gets.chomp
      move_towards = [row,column] 
      puts ' - - - - -' 
      legal_move_to = find_player_input_coordinates(row,column)
    end
    puts "You want to move your piece to row: #{row} ,#{column}"
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
    
    if is_current_player_in_check == true
      if check_possible_move_for(piece,from,towards).include?(towards)
        board[from[0]][from[1]] = '-'
        board[towards[0]][towards[1]] = piece
        other_players_moves = opp_team_captures
      #- - - - FOR BLACK - - - - - - - 
        if self.turn == "BLACK"  
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
        end
    # - - - -FOR WHITE - - - - - - - - 
        if self.turn == "WHITE"
          if other_players_moves.include?(find_current_players_king[1]) == false
            player_two[2] = false
            puts "king not in check!(line 274)"
            return true
          else 
            board[from[0]][from[1]] = piece  
            board[towards[0]][towards[1]] = other_piece 
            puts "ILLEGAL MOVE!! CANNOT MOVE KING INTO CHECK! (line 279)"
            return false 
          end  
        end 
      else
        puts "ILLEGAL MOVE 1 (line 280)"
        return false
      end    
    # - NOT IN CHECK -
    elsif is_current_player_in_check == false
      puts"____________________"
      if check_possible_move_for(piece,from,towards).include?(towards)
        if piece == "♔" || piece == "♚"
          if king_future_capture.include?(towards)
            puts "ERROR: cannot move your king into check!!!"
            return false
          end  
        end  

        if other_piece != '-' && self.turn == "WHITE"
          self.player_one[1] << other_piece
        end
        if other_piece != '-' && self.turn == "BLACK"
          self.player_two[1] << other_piece
        end
        # UPDATE the board // MOVE the piece
        board[from[0]][from[1]] = '-'
        board[towards[0]][towards[1]] = piece
        if opp_team_captures.include?(find_current_players_king[1])
          board[from[0]][from[1]] = piece
          board[towards[0]][towards[1]] = '-'
          puts "ERROR: this move puts your king into check!!!"
          return false
        end   
        # other player in check?
        future_moves = [current_team_captures]
        if future_moves.flatten!(1).include?(find_other_players_king[1])
          if turn == "WHITE"
            player_two[2] = true
          end 
          if turn == "BLACK"
            player_one[2] = true
          end   
        end 
        return true 
     else
        2.times { |i| puts " " }
        puts "ERROR:  ILLEGAL MOVE!!"
        puts "PLEASE: re-enter coordinates"
        return false  
     end   
    end 
  end 

  def other_players_pawns
   pawns = []
    
    if self.turn == "BLACK"
      white_pawns = ['♟']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if white_pawns.include?(obj[0]) 
              pawns << obj
            end 
            j+=1
          end
          i += 1
        end
        return pawns
    end
    if self.turn == "WHITE"
      black_pawns = ['♙']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if black_pawns.include?(obj[0]) 
              pawns << obj
            end 
            j+=1
          end
          i += 1
        end
        return pawns
    end
  end

  def current_player_pawns
    pawns = []
    if self.turn == "WHITE"
      white_pawns = ['♟']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if white_pawns.include?(obj[0]) 
              pawns << obj
            end 
            j+=1
          end
          i += 1
        end
        return pawns
    end
    if self.turn == "BLACK"
      black_pawns = ['♙']
      i = 0
        while i < 8
          j = 0 
          while j < 8
            obj = [board[i][j],[i,j]]
            if black_pawns.include?(obj[0]) 
              pawns << obj
            end 
            j+=1
          end
          i += 1
        end
        return pawns
    end
  end  

  def current_pawn_captures
    captures = []
    current_pawn_locations = []
    current_player_pawns.each do |pawn| 
      current_pawn_locations << pawn[1]
    end
    if self.turn == "BLACK"
      current_pawn_locations.each do |item|
        captures << [item[0] + 1,item[1] + 1]
        captures << [item[0] + 1,item[1] - 1]
      end
      captures.uniq!
      captures.delete_if do |capture|
        capture[0] > 7
      end 
      captures.delete_if do |capture|
        capture[1] > 7
      end 
      captures.delete_if do |capture|
        capture[1] < 0
      end  
      return captures  
    end

    if self.turn == "WHITE"
      current_pawn_locations.each do |item|
        captures << [item[0] - 1,item[1] + 1]
        captures << [item[0] - 1,item[1] - 1]
      end
      captures.uniq!
      captures.delete_if do |capture|
        capture[0] < 0
      end 
      captures.delete_if do |capture|
        capture[1] > 7
      end 
      captures.delete_if do |capture|
        capture[1] < 0
      end 
      return captures  
    end
  end  

  def other_pawns_capture
    captures = []
    current_pawn_locations = [] 
    other_players_pawns.each do |pawn| 
      current_pawn_locations << pawn[1]
    end
    if self.turn == "WHITE"
      current_pawn_locations.each do |item|
        captures << [item[0] + 1,item[1] + 1]
        captures << [item[0] + 1,item[1] - 1]
      end
      captures.uniq!
    
      captures.delete_if do |capture|
        capture[0] > 7
      end 
    
      captures.delete_if do |capture|
        capture[1] > 7
      end 

      captures.delete_if do |capture|
        capture[1] < 0
      end  
      return captures  
    end

    if self.turn == "BLACK"
      current_pawn_locations.each do |item|
        captures << [item[0] - 1,item[1] + 1]
        captures << [item[0] - 1,item[1] - 1]
      end
      captures.uniq!
    
      captures.delete_if do |capture|
        capture[0] < 0
      end 
    
      captures.delete_if do |capture|
        capture[1] > 7
      end 

      captures.delete_if do |capture|
        capture[1] < 0
      end 
      return captures  
    end
  end  

  def look_for_check_mate
    king = find_current_players_king
    king_moves = check_possible_move_for(king[0],king[1],['inv','inv'])
    opp_pieces = find_all_opposite_players_pieces #[ ["♖", [0, 0]],......]
    attack_paths = []
    king_cannot_move   = false
    king_cannot_defend = false
    king_under_attack  = false 
    
    if opp_team_captures.include?(king[1]) 
      king_under_attack  = true
      puts "IS KING BEING ATTACKED? #{king_under_attack}" 
      if king_future_capture != []
        king_moves.delete_if do |move|
          king_future_capture.include?(move)
        end 
      end

      if king_moves.empty?
        king_cannot_move = true
        puts "KING CANNOT MOVE AWAY? #{king_cannot_move}"
      end 

      how_many_attackers = 0
      opp_pieces.each do |piece|
        opp_pieces.delete_if {|piece| piece[0] == "♔" || piece[0] == "♚"}
        if check_possible_move_for(piece[0],piece[1],['inv','inv']).include?(king[1])
          how_many_attackers += 1
        end     
      end 
      if how_many_attackers > 1
        king_cannot_defend = true
        puts "CAN KING NOT BE DEFENDED? #{king_cannot_defend}"
      else   
        opp_pieces.each do |piece|
          opp_pieces.delete_if {|piece| piece[0] == "♔" || piece[0] == "♚"}
            if check_possible_move_for(piece[0],piece[1],['inv','inv']).include?(king[1])
              if piece[0] == "♘" || piece[0] == "♞"
                attack_paths << piece[1]
              elsif piece[0] == "♙ " || piece[0] == "♟"
                attack_paths << piece[1]
              elsif king_surrounding_area.include?(piece[1]) 
                attack_paths << piece[1] 
              elsif king_surrounding_area.include?(piece[1]) == false 
                linear_attacking_pieces = ['♕','♗','♖','♛','♝','♜']
                if linear_attacking_pieces.include?(piece[0])
                  strike = check_possible_move_for(piece[0],piece[1],['inv','inv'])
                  vertex = strike & spaces_around_king
                  strike_path = create_linear_path(king[1],vertex.flatten!(1))
                  attack_paths << strike_path
                end                     
              end
            end     
          end 
        end  
  
      defends = attack_paths[0] & current_team_defends_king
      if defends == []
        king_cannot_defend = true
        puts "CAN KING NOT BE DEFENDED? #{king_cannot_defend}"
      end 
      if king_under_attack && king_cannot_move && king_cannot_defend
        self.check_mate = true
      end  
    else
      king_under_attack  = false
    end  
  end 

  def king_future_capture
    king = find_current_players_king
    king_moves = check_possible_move_for(king[0],king[1],['inv','inv'])
    copy_board = Marshal.load( Marshal.dump(board) )
    original_king_position = king[1]
    king_image = king[0]
    illegal_moves = []
    
    if king_moves != []    
      board[king[1][0]][king[1][1]] = '-'                
      i = 0
      while i < king_moves.length
        location_being_checked = king_moves[i]
        reset_piece = board[king_moves[i][0]][king_moves[i][1]] 
        board[king_moves[i][0]][king_moves[i][1]] = king[0]
        x = opp_team_captures & king_moves
        if x != []
           illegal_moves << x 
        end
        board[king_moves[i][0]][king_moves[i][1]] = reset_piece
         i += 1               
      end  
    end     
    self.board = copy_board   
    if illegal_moves.flatten!(1) == nil
      return []
    else
      illegal_moves.uniq!
       return  illegal_moves 
    end  
  end

  def opp_team_captures
    opp_moves = [[other_pawns_capture]]
    opp_team = find_all_opposite_players_pieces
    opp_team.delete_if {|piece| piece[0] == '♟' || piece[0] == '♙'}
    
    opp_team.each do |item|
      if check_possible_move_for(item[0],item[1],['inv','inv']) != []
        opp_moves << [check_possible_move_for(item[0],item[1],['inv','inv'])]
      end  
    end
    opp_moves.flatten!(1)
    opp_moves.uniq!
    opp_moves.flatten!(1)
    opp_moves.uniq!   
  end  

  def current_team_captures
    current_moves = [current_pawn_captures]
    current_team = find_all_current_players_pieces
    current_team.delete_if {|piece| piece[0] == '♟' || piece[0] == '♙'}
    current_team.each do |item|
      if check_possible_move_for(item[0],item[1],['inv','inv']) != []
        current_moves << check_possible_move_for(item[0],item[1],['inv','inv'])
      end  
    end
    current_moves.flatten!(1)
    current_moves.uniq!
    current_moves
  end 

  def current_team_defends_king
    current_moves = []
    current_team = find_all_current_players_pieces
    current_team.delete_if {|piece| piece[0] == '♚' || piece[0] == '♔'}
    current_team.each do |item|
      if check_possible_move_for(item[0],item[1],['inv','inv']) != []
        current_moves << check_possible_move_for(item[0],item[1],['inv','inv'])
      end  
    end
    current_moves.flatten!(1)
    current_moves.uniq!
    current_moves
  end  

  def spaces_around_king
    king = find_current_players_king[1] #[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
    x = king[0]
    y = king[1]
    spaces = [[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
    spaces.delete_if{|space| space[0] > 7}
    spaces.delete_if{|space| space[0] < 0}
    spaces.delete_if{|space| space[1] > 7}
    spaces.delete_if{|space| space[1] < 0}
    spaces.delete_if{|space| board[space[0]][space[1]] != '-'}
    return spaces
    # king => [x,y] 
  end  

  def king_surrounding_area
    king = find_current_players_king[1] #[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
    x = king[0]
    y = king[1]
    spaces = [[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y],[x-1,y-1]]
    spaces.delete_if{|space| space[0] > 7}
    spaces.delete_if{|space| space[0] < 0}
    spaces.delete_if{|space| space[1] > 7}
    spaces.delete_if{|space| space[1] < 0}
    return spaces
  end  

  def create_linear_path(from,away)
    p from #[0,3] king
    p away #[1,3] next space
    x = (away[0] - from[0])
    y = (away[1] - from[1])
    path = []
    space = board[from[0]+x][from[1]+y]
    next_move = [from[0]+x,from[1]+y]
    
    while space == '-'
        path << next_move
        next_move = [next_move[0]+x,next_move[1]+y]
        space = board[next_move[0]][next_move[1]]
    end
    path << next_move
    return path 
  end  

  def find_all_current_players_pieces
    current_player_pieces = []
    
    if self.turn == "WHITE"
      white_pieces = ['♜','♞','♝','♛','♚','♟']
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
     puts 'INVALID ENTRY (line 669)' 
     return false
    elsif x < 0 
     puts 'INVALID ENTRY (line 672)'
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
       puts "Error: INVALID entry (858)"
       return false
    end
    piece = board[x][y]
  end

  def does_piece_belong_to_player(piece)
    black_pieces = ['♖','♘','♗','♕','♔','♙']
    white_pieces = ['♜','♞','♝','♛','♚','♟']
    if self.turn == "WHITE" &&  white_pieces.include?(piece)
      return true
    elsif self.turn == "BLACK" &&  black_pieces.include?(piece)
      return true
    else      
      return false
    end
  end 

  def check_possible_move_for(piece,location,destination)
    black_pieces = ['♖','♘','♗','♕','♔','♙']
    white_pieces = ['♜','♞','♝','♛','♚','♟']
    x = location[0].to_i
    y = location[1].to_i
    x_to = destination[0].to_i
    y_to = destination[1].to_i
    value_of_destination_cell = board[x_to][y_to]

    case piece 
      when "♟"
        can_move  = []
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
        return can_move
  
      when "♙"
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
        return can_move
  
      when "♜"
         can_move  = []
         horizontal  = board[x]     
         #ROW LEFT
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
         #ROW RIGHT
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
         #COLUMN FOWRWARD
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
          #COLUMN BACKWARD
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
  
      when "♖"
         can_move  = []
         horizontal  = board[x]             
         #ROW LEFT
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
         #ROW RIGHT
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
         #COLUMN FOWRWARD
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
          #COLUMN BACKWARD
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
  
      when "♝"
          can_move  = []
          #Diagonal  x+1, y+1
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
            diagonal_1[1] +=             
          end  
          #Diagonal  x-1, y-1
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
 
      when "♗"
          can_move  = []
          #Diagonal  x+1, y+1
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
          #Diagonal  x-1, y-1
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
          #Diagonal  x+1, y-1
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
          #Diagonal  x-1, y+1
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

      when "♛"
        can_move   = []
        horizontal = board[x]     
         #ROW LEFT
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
         #ROW RIGHT
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
         #COLUMN FOWRWARD
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
          #COLUMN BACKWARD
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
           #Diagonal  x+1, y+1
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
          #Diagonal  x-1, y-1
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
          #Diagonal  x+1, y-1
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
          #Diagonal  x-1, y+1
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
 
      when "♕"
         can_move  = []
         horizontal  = board[x]             
         #ROW LEFT
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
         #ROW RIGHT
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
         #COLUMN FOWRWARD
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
          #COLUMN BACKWARD
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
           #Diagonal  x+1, y+1
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
          #Diagonal  x-1, y-1
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
          #Diagonal  x+1, y-1
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
          #Diagonal  x-1, y+1
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
        #puts "KING all moves -> #{all_moves}"
        return all_moves

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
          # p piece_obj
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
        return all_moves
      end
  end 

end #end of chess	
