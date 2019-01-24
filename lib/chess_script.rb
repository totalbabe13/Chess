require_relative('chess_objects')
require_relative('user_interface')
require "pry"


include Ui_messages

 welcome_message #UI message CHESS /PRESS ENTER
 user_response_1 = gets.chomp
 saved = false

 if user_response_1
 	input_valid_1 = false

 	while input_valid_1 == false
 	  load_or_new #UI message 1 or 2	
 	  user_response_2 = gets.chomp
 	  if user_response_2 == '1' || user_response_2 == '2'
 	  	input_valid_1 = true
 	  end	
    end

 	if user_response_2 == '1'
 	    new_game_player1
 	    player_one = gets.chomp
 	    new_game_player2
 	    player_two = gets.chomp
        new_game = Chess_game.new(player_one ,player_two)
 	    
 	    new_game.to_json

 	    while new_game.check_mate == false 
 	      if ask_to_save == true
 	       saved = true
 	      end 	
 	   	  break if saved
 	   	  new_game.look_for_check_mate
          new_game.print_board
          new_game.change_player
          puts "- -after change players- -"
          new_game.look_for_check_mate
        end 

        puts "after while loop"

        if new_game.check_mate == true
          puts " -G-A-M-E-   -O-V-E-R-"
          puts "#{new_game.turn} LOSES "
        end

        save_message(new_game)
        
        	
      



 	elsif user_response_2 == '2'
 	 puts "test - Load old game path"
 	else 
 	 puts " INVALID ENTRY"	
 	end	
 	 			
 end	


	