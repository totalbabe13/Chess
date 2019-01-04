require_relative('chess_objects')
require_relative('user_interface')


include Ui_messages

 welcome_message #UI message CHESS /PRESS ENTER
 user_response_1 = gets.chomp

 if user_response_1
 	# load_or_new #UI message 1 or 2
 	input_valid = false
 	while input_valid == false
 	  load_or_new #UI message 1 or 2	
 	  user_response_2 = gets.chomp
 	  if user_response_2 == '1' || user_response_2 == '2'
 	  	input_valid = true
 	  end	
    end
 	if user_response_2 == '1'
 	   new_game_player1
 	     player_one = gets.chomp
 	   new_game_player2
 	     player_two = gets.chomp
 	
       new_game = Chess_game.new(player_one,player_two)
       new_game.print_board
       # new_game.move_piece(ask_player_to_select_piece,ask_player_to_choose_destination)
       new_game.change_player
       new_game.print_board
       
       # new_game.player_input_coordinates(5,'d')



 	elsif user_response_2 == '2'
 	 puts "test - Load old game path"
 	else 
 	 puts " INVALID ENTRY"	
 	end	
 	 			
 end	


	