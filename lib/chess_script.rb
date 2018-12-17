require_relative('chess_objects')
require_relative('user_interface')


include Ui_messages

# welcome_message

testing_game = Chess_board.new
testing_game.print_board
 puts ' - - - -'

testing_game.populate_board
testing_game.print_board
