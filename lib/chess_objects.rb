class Chess_board
	attr_accessor :board

	def initialize
	    #@board = Array.new(8) { Array.new(8,'-') }
      @board = [
        ['♖','♘','♗','♕','♔','♗','♘','♖'], #black
        ['♙','♙','♙','♙','♙','♙','♙','♙'], #black
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['♟','♟','♟','♟','♟','♟','♟','♟'], #white
        ['♜','♞','♝','♛','♚','♝','♞','♜']  #white
      ]
	end	

	def print_board
    system("clear")
        i = 0
        puts "     A   B   C   D   E   F   G   H"
        puts "   _________________________________"
        while i < board.length
        	puts (i+1).to_s + ' |  ' + board[i].join(" | ") + " | "+ (i+1).to_s 
        	i += 1
        end
        puts "   _________________________________"
        puts ''
        puts "     A   B   C   D   E   F   G   H"
	end	
end	


