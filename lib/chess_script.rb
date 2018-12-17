require_relative('chess_objects')
require_relative('user_interface')


include Ui_messages

# welcome_message

testing_board = Chess_board.new
test_pawn = Pawn.new


testing_board.board[0][0] = test_pawn.name + '-' + test_pawn.color
p testing_board.board[0] 