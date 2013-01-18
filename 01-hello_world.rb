#!/usr/bin/ruby

require 'rubygems'
require 'ncurses'


Ncurses.initscr
Ncurses.printw "hello world!"

#Ncurses.raw
#Ncurses.cbreak
Ncurses.noecho

Ncurses.refresh

loop do
  break if Ncurses.getch == ?q
end

Ncurses.endwin

