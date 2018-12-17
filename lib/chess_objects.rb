class Chess_board
	attr_accessor :board

	def initialize
	  # @board = Array.new(8) { Array.new(8) }
      @board = [
        ['R','k','B','Q','K','B','k','R'],
        ['P','P','P','P','P','P','P','P'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['P','P','P','P','P','P','P','P'],
        ['R','k','B','Q','K','B','k','R']
      ]

	end	

	def print_board
        i = 0
        while i < board.length
        	p board[i].join("   ")
        	i += 1
        end	
       
	end	
end	

 