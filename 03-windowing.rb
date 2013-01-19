#!/usr/bin/ruby

require 'rubygems'
require 'ncurses'



def initialize_curses
  Ncurses.initscr
  #Ncurses.printw "hello world!"

  # SETUP INPUTS
  Ncurses.raw
  #Ncurses.cbreak
  Ncurses.keypad Ncurses.stdscr, TRUE
  Ncurses.noecho


  Ncurses.start_color
  Ncurses.refresh

  # GET WINDOW SIZE
  @rows = Ncurses.getmaxy Ncurses.stdscr
  @cols = Ncurses.getmaxx Ncurses.stdscr

end

def initialize_header
  @header = create_boxed_window 3, @cols, 0, 0
  Ncurses.wattron @header, Ncurses::A_BOLD 
  Ncurses.mvwprintw @header, 1, 3, "Hello World"
  Ncurses.wrefresh @header 
end

def initialize_footer
  @footer = Ncurses.newwin 1, @cols, @rows-1, 0
  insert_string = "Footer"
  footer_string = " " * (@cols+1)
  #footer_string = 178.chr * (@cols+1)
  footer_string[-2-insert_string.length..-2] = insert_string
  Ncurses.wattron @footer, Ncurses::A_STANDOUT
  Ncurses.mvwprintw @footer, 0, 0, footer_string
  Ncurses.addch 178
  Ncurses.wrefresh @footer
end

def initialize_main
  @main = create_boxed_window @rows-4, @cols, 3, 0
  Ncurses.wmove @main, 1, 1

end

def create_boxed_window(height, width, starty, startx)
  local_win = Ncurses.newwin(height, width, starty, startx)
  Ncurses.wattron local_win, Ncurses::A_STANDOUT
  Ncurses.box local_win, 0, 0
  Ncurses.wrefresh local_win
  return local_win 
end

initialize_curses
initialize_header
initialize_footer
initialize_main

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
      Ncurses.wprintw @main, char.chr
      Ncurses.wrefresh @main
    end
  rescue
  end

end

Ncurses.endwin

