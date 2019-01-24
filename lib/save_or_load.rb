require 'json'

module Game_data_functions

  def tester_function
  	puts "testing save function"
  end	
  
  def to_json
    game = {
    	:board => @board,
    	:player_one => @player_one,
    	:player_two => @player_two,
    	:check => @check, 
    	:check_mate => @check_mate,
    	:turn => @turn
    }

    puts JSON.generate(game)
 #    @board=
 #  [["♖", "♘", "♗", "♔", "♕", "♗", "♘", "♖"],
 #   ["♙", "♙", "♙", "♙", "♙", "♙", "♙", "♙"],
 #   ["-", "-", "-", "-", "-", "-", "-", "-"],
 #   ["-", "-", "-", "-", "-", "-", "-", "-"],
 #   ["-", "-", "-", "-", "-", "-", "-", "-"],
 #   ["-", "-", "-", "-", "-", "-", "-", "-"],
 #   ["♟", "♟", "♟", "♟", "♟", "♟", "♟", "♟"],
 #   ["♜", "♞", "♝", "♚", "♛", "♝", "♞", "♜"]],
 # @check=false,
 # @check_mate=false,
 # @player_one=["a", [], false],
 # @player_two=["a", [], false],
 # @turn="WHITE">
  end

  def self.from_json(string)
    # data = JSON.load string
    # self.new(data['name'], data['age'], data['gender'])
  end

end	