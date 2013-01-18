#!/usr/bin/ruby

require 'rubygems'
require 'ncurses'


Ncurses.initscr
Ncurses.printw "hello world!"

Ncurses.raw
#Ncurses.cbreak

Ncurses.keypad Ncurses.stdscr, TRUE
Ncurses.noecho

Ncurses.refresh


bold = false

loop do
  #break if Ncurses.getch == ?q
  char = Ncurses.getch

  begin

    # QUIT ON F4
    if char == Ncurses::KEY_F4
      break

    # TOGGLE BOLD WITH F2
    elsif char == Ncurses::KEY_F2
      if bold == false
        Ncurses.attron(Ncurses::A_BOLD)
        bold = true
      else
        Ncurses.attroff(Ncurses::A_BOLD)
        bold = false
      end
    # OTHERWISE TYPE TO SCREEN
    else
      Ncurses.printw char.chr
    end
  rescue
  end

end

Ncurses.endwin

