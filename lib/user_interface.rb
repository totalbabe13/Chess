module Ui_messages

  def welcome_message
  	system("clear")
  	  
    puts '                 ' "\e[5m""MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMN0kkkXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMk.  .kMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMXc   :XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMWWWMMMMMMMWk.  .xWMWWWMMMMMMMMMMMMMMWWWWMMMMMMMMMMMWWWWMMMMMMMMMMMWWWWMMMMMMMMMMMMMM
                 MMMMMMMMMMMN0xl;;;;:oONMMMXc   'ol:;;;ckNMMMMMWXkolc;,;:oKWMMMMWXxl;;;;cdKWMMMN0dc;;;;lkNMMMMMMMMMMM
                 MMMMMMMMMXd;.   ..   .xWMMk.     ..    .kWMMWKl.    ..   'OMMMNd.   ..   lNMM0c.  ...  .xWMMMMMMMMMM
                 MMMMMMMWO,   ,dOKO:.'l0WMXc    ;x00c.  .xMMWk'   ,ldOx,   lWMWd.  .dK0k:'xWMX:   ,kK0d';0MMMMMMMMMMM
                 MMMMMMWk.  .lXMMMMNKNMMMWk.  .oNMMNl   ;KMWO'    .'''..   oWMNl    ,lkXXKNMM0,   .;d0XXXWMMMMMMMMMMM
                 MMMMMMK;   :XMMMMMMMMMMMXc   ;XMMMO'  .dWMX:    .........,OMMWKc.     .oXMMMWk;.    .,kWMMMMMMMMMMMM
                 MMMMMMO.   :XMMMMNXNMMMMk.  .xWMMNl   ;KMMO'   cKXXXXX00KNWW0kXWXkl.   .OMNkOWNKx:.   :XMMMMMMMMMMMM
                 MMMMMM0,   .:xkxo,.cKMMNc   :XMMMO'  .dWMM0,   .lkOkxl''dNMK;.;dO0x,   :KMk..cx0Oo.  .oNMMMMMMMMMMMM
                 MMMMMMWk'         .lKMWk.  .xWMMNl   ;KMMMWk'         .,dNM0,    .   .lKMWx.       .,xNMMMMMMMMMMMMM
                 MMMMMMMMXxlc:::coOXWMMW0ollxXMMMNkolo0WMMMMWXxlcc::cld0NMMMWKdlc:ccokXWMMMNOoc::cldONMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMWMMMMMMMMMMMMMWWMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM" "\e[m"
                 
  	3.times { |i| puts " " }
  	puts"                                        \u00A9 Leonardo Kaplan - Totalbabe13 Productions \u2665 "
  	puts'                                    - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
  	3.times { |i| puts " " }
  	puts "                                                          --> PRESS ENTER <--"
  end	  

  def load_or_new
  	system("clear")
  	15.times { |i| puts " " }
  	puts "                                        ♜  Enter 1: to START a NEW GAME"
  	puts "                                        ♖  Enter 2: to LOAD a SAVED GAME"
  	puts "                                        THEN PRESS -->  RETURN KEY "
    15.times { |i| puts " " }
    # user_response = gets.chomp
  end

  def new_game_player1
    system("clear")
    15.times { |i| puts " " }
    puts "                                        ♟  white - PLAYER ONE Enter Your name:"
    #puts "                                        "
    puts "                                        THEN PRESS -->  RETURN KEY "
    15.times { |i| puts " " }
  end 

  def new_game_player2
    system("clear")
    15.times { |i| puts " " }
    puts "                                        ♙ black - PLAYER TWO Enter Your name:"
    #puts "                                        "
    puts "                                        THEN PRESS -->  RETURN KEY "
    15.times { |i| puts " " }
  end
 
  def ask_to_save
    system("clear")
    15.times { |i| puts " " }
    puts "SAVE GAME ???"
    puts "YES : 1 and press ENTER"
    puts "NO  : press ENTER"
    user_response = gets.chomp
    if user_response == 1.to_s
     return true
    else
     return false
    end  
  end

  def save_message
    system("clear")
    15.times { |i| puts " " }
    puts "Type in a name to save you game under:}"
    saved_game = gets.chomp
    "saved_games/#{saved_game}.json"
  end

  def load_message
    system("clear")
    15.times { |i| puts " " }
    puts "Type in the name you saved your game under:}"
    load_game = gets.chomp
    "saved_games/#{load_game}.json"
  end  

end