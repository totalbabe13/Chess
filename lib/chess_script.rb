require_relative('chess_objects')
require_relative('user_interface')
require_relative('save_or_load')
require "pry"


include Ui_messages
include Game_data_functions

 welcome_message 
 user_response_1 = gets.chomp
 saved = false

 if user_response_1
 	input_valid_1 = false

 	while input_valid_1 == false
 	  load_or_new 	
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
        new_game   = Chess_game.new(player_one ,player_two)
 	    p new_game
 	    while new_game.check_mate == false 
 	      if ask_to_save == true
 	        saved = true
 	      end 	
 	   	  break if saved
 	   	  new_game.look_for_check_mate
          new_game.print_board
          new_game.change_player
          new_game.look_for_check_mate
        end 

        if new_game.check_mate == true
          puts " -G-A-M-E-   -O-V-E-R-"
          puts "#{new_game.turn} LOSES "
          puts "press enter to continue"
          clear = gets.chomp
        end
        game_name   = save_message 
        game_string = new_game.to_json  
        saved_game  = create_game_file(game_string,game_name)        
   
 	elsif user_response_2 == '2'
 	    load_game = load_game_file(load_message)
 	    while load_game.check_mate == false 
 	        if ask_to_save == true
 	        saved = true
 	        end 	
 	   	    break if saved
 	   	    load_game.look_for_check_mate
            load_game.print_board
            load_game.change_player
            load_game.look_for_check_mate
        end 
 	else 
 	  puts " INVALID ENTRY: ENTER 1 or 2"	
 	end			
 end	


	