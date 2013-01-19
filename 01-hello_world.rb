#!/usr/bin/ruby

require 'rubygems'
require 'ncurses'


Ncurses.initscr
Ncurses.printw "hello world!"

Ncurses.raw
#Ncurses.cbreak
Ncurses.noecho

Ncurses.refresh

loop do
  char = Ncurses.getch
  Ncurses.printw char.to_s
  break if char  == ?q
end

Ncurses.endwin

