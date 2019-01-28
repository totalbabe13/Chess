require './lib/chess_objects'

RSpec.describe Chess_game do
  describe "#initialize" do

    it "creates player one" do
      new_game = Chess_game.new('Leonardo','Dana')
      expect(new_game.player_one[0]).to eql('Leonardo')
    end

    it "creates player two" do
      new_game = Chess_game.new('Leonardo','Dana')
      expect(new_game.player_two[0]).to eql('Dana')
    end

    it "starts every game with the white pieces" do
      new_game = Chess_game.new('Leonardo','Dana')
      expect(new_game.turn).to eql('WHITE')
    end
    
    it "starts every game with checkmate as false" do
      new_game = Chess_game.new('Leonardo','Dana')
      expect(new_game.check_mate).to eql(false)
    end

    it "starts every NEW game with a set board" do
    	new_game = Chess_game.new('Leo','Dana')
    	expect(new_game.board).to eql([['♖','♘','♗','♔','♕','♗','♘','♖'],['♙','♙','♙','♙','♙','♙','♙','♙'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['-','-','-','-','-','-','-','-'],['♟','♟','♟','♟','♟','♟','♟','♟'],['♜','♞','♝','♚','♛','♝','♞','♜']])
    end	

  end
end