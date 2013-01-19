#!/usr/bin/ruby

#require 'rubygems'
#require 'ncurses'
require 'curses'


Curses.init_screen
Curses.addstr "hello world!"

Curses.raw
#Ncurses.cbreak
Curses.noecho

Curses.refresh

loop do
  char = Curses.getch
  Curses.addstr char.to_s
  Curses.addstr Curses.curx
  break if char  == ?q
end

Curses.endwin

