require_relative('chess_objects')
require_relative('user_interface')


include Ui_messages

 welcome_message
 user_response_1 = gets.chomp
 if user_response_1
 	load_or_new
 	
 	user_response_2 = gets.chomp
 	 if user_response_2 == '1'
 	 	puts "test - Start new game path"
 	 elsif user_response_2 == '2'
 	 	puts "test - Load old game path"
 	 else 
 	    puts " INVALID ENTRY"	
 	 end	
 	 			
 end	

# testing_game = Chess_board.new
# testing_game.print_board

	