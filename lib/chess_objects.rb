class Chess_board
	attr_accessor :board

	def initialize
	   @board = Array.new(8) { Array.new(8) }
      # @board = [
      #   ['R','k','B','Q','K','B','k','R'],
      #   ['P','P','P','P','P','P','P','P'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['-','-','-','-','-','-','-','-'],
      #   ['P','P','P','P','P','P','P','P'],
      #   ['R','k','B','Q','K','B','k','R']
      # ]

	end	

	def print_board
        i = 0
        while i < board.length
        	p board[i].join(" ? ")
        	i += 1
        end	  
	end	
end	

class Pawn 
  attr_accessor :position, :name, :color

  def initialize
    @name = 'Pawn'
    @color = nil
    # @position = [nil,nil]
  end  
end 


class Rook
  def initialize
    @name = 'Rook'
    @color = nil
    # @position = [nil,nil] 
  end  
end 

class Knight
  def initialize 
    @name = 'Knight'
    @color = nil
  end  
end 

class Bishop
  def initialize 
    @name = 'Bishop'
    @color = nil
  end  
end 

class Queen
  def initialize
    @name = 'Queen'
    @color = nil 
  end  
end 

class King
  def initialize
    @name = 'King'
    @color = nil 
  end  
end 