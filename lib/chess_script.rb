require_relative('chess_objects')
require_relative('user_interface')


include Ui_messages

welcome_message
testing_board = Chess_board.new
testing_board.print_board

