require 'json'
require_relative 'chess_objects'

module Game_data_functions	

    def to_json
      game = {
    	:board => @board,
    	:player_one => @player_one,
    	:player_two => @player_two,
    	:check_mate => @check_mate,
    	:turn => @turn
      }
    string = JSON.generate(game)
    end

    def create_game_file(game_json,game_title)
  	  game_file_name = game_title
  	  line1 = game_json
  	  File.open(game_file_name, "w") do |out_file|
  		out_file.write(line1)	
  	  end	
    end	

    def load_game_file(game_name)
    	if File.exists?(game_name)
    		puts "test works!"
    		json =  File.read(game_name)
    		game  = JSON.parse(json)
    		Chess_game.new(game["player_one"],game["player_two"], game['turn'],game['check_mate'] ,game['board'])
    	end	
    end	

end	



# def self.from_json(string)
  #   # data = JSON.load string
  #   # self.new(data['name'], data['age'], data['gender'])
  # end
# F = open.(Dir.pwd, "/data/folder/#{@file_name}","w+")
# newfilename = "16.Sample2.txt"
# line1 = "BOOYAH"

# File.open(newfilename, "w") do |out_file|
#   out_file.write(line1)
# end



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