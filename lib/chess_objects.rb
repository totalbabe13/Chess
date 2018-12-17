class Chess_board
	attr_accessor :board

	def initialize
	   # @board = Array.new(8) { Array.new(8) }
      @board = [
        ['R','n','B','Q','K','B','n','R'], #black
        ['P','P','P','P','P','P','P','P'], #black
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-'],
        ['P','P','P','♙','P','P','P','P'], #white
        ['R','n','B','Q','K','B','n','R']  #white
      ]

	end	

  def populate_board
    #BLACK make row of pieces rook,knight bishop, queen king ...
    x = [ Rook.new('black').image, 
        Knight.new('black').image, 
        Bishop.new('black').image, 
         Queen.new('black').image, 
          King.new('black').image, 
        Bishop.new('black').image, 
        Knight.new('black').image, 
          Rook.new('black').image ]
    board[0] = x

    y = [ Rook.new('white').image, 
        Knight.new('white').image, 
        Bishop.new('white').image, 
         Queen.new('white').image, 
          King.new('white').image, 
        Bishop.new('white').image, 
        Knight.new('white').image, 
          Rook.new('white').image ]
    board[7] = y
    #make row of pawns
    board[1].map! {|piece| piece = Pawn.new("black").image} 
    board[6].map! {|piece| piece = Pawn.new("white").image}

  end  

	def print_board
    system("clear")
        i = 0
        puts "     A  B  C  D  E  F  G  H"
        puts "     _______________________"

        while i < board.length
        	puts i.to_s + ' |  ' + board[i].join("  ") + " | "+ i.to_s 
        	i += 1
        end

        puts "     ______________________"
        puts ''
        puts "     A  B  C  D  E  F  G  H"	  
	end	
end	

#  - - - - PAWN class - - - - 
class Pawn 
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Pawn'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♙'
    elsif color == 'white'
      image = '♟'
    end      
  end

end 

# - - - - - - - - - - - - - - -


#  - - - - ROOK class - - - - 
class Rook
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Rook'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♖'
    elsif color == 'white'
      image = '♜'
    end      
  end 
 
end 

class Knight
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Knight'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♘'
    elsif color == 'white'
      image = '♞'
    end      
  end 
end 

class Bishop
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Bishop'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♗'
    elsif color == 'white'
      image = '♝'
    end      
  end 
  
end 

class Queen
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Queen'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♕'
    elsif color == 'white'
      image = '♛'
    end      
  end 
end 

class King
  attr_accessor :position, :name, :color, :image

  def initialize(color)
    @name = 'Queen'
    @color = color
    @image = choose_color
    # @position = [nil,nil]
  end 

  def choose_color
    if color == 'black'
      image = '♔'
    elsif color == 'white'
      image = '♚'
    end      
  end   
end 