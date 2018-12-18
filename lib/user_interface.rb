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
  	puts "                                                          --> PRESS ANY KEY <--"
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


end