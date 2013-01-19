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
  #Ncurses.wattron @header, Ncurses::A_BOLD 
  Ncurses.mvwprintw @header, 1, 3, "Hello World"
  Ncurses.wrefresh @header 
end

def initialize_footer
  @footer = Ncurses.newwin 1, @cols, @rows-1, 0
  insert_string = "Footer"
  #footer_string = " " * (@cols)
  #footer_string[-1-insert_string.length..-1] = insert_string
  Ncurses.wattron @footer, Ncurses::A_STANDOUT
  #Ncurses.mvwprintw @footer, 0, 0, footer_string
  Ncurses.mvwprintw @footer, 0, 0, " " * @cols
  Ncurses.mvwprintw @footer, 0, @cols-insert_string.length-2, insert_string
  Ncurses.wrefresh @footer
end

def initialize_main
  @main = create_boxed_window @rows-4, @cols, 3, 0
  Ncurses.wmove @main, 1, 1
  Ncurses.wrefresh @main
end

def create_boxed_window(height, width, starty, startx)
  local_win = Ncurses.newwin(height, width, starty, startx)
  Ncurses.wattron local_win, Ncurses::A_STANDOUT
  Ncurses.box local_win, 0, 0
  Ncurses.wrefresh local_win
  return local_win 
end

def footnote(string)
  #footer_string = " " * (@cols+1)
  #footer_string[2..2+string.length]=string
  #Ncurses.mvwprintw @footer, 0, 0, footer_string
  Ncurses.mvwprintw @footer, 0, 0, " " * (@cols)
  Ncurses.mvwprintw @footer, 0, 2, string
  Ncurses.wrefresh @footer
end

def draw_grid_lines
  Ncurses.wstandend @main
  current_line = 5
  while current_line <= @main.getmaxy
    Ncurses.mvwprintw @main, current_line, 1, "-" * (@cols-2)
    Ncurses.mvwprintw @main, current_line+5, 1, "_" * (@cols-2)
    current_line += 10
  end
  Ncurses.wrefresh @main

end

initialize_curses
initialize_header
initialize_footer
initialize_main
draw_grid_lines

bold = false

loop do
  #break if Ncurses.getch == ?q
  char = Ncurses.getch

  #begin

    # QUIT ON F4
    if char == Ncurses::KEY_F4
      break

    # TOGGLE BOLD WITH F2
    elsif char == Ncurses::KEY_F2
      if bold == false
        Ncurses.wattron @main, Ncurses::A_BOLD
        bold = true
      else
        Ncurses.wattroff @main, Ncurses::A_BOLD
        bold = false
      end
    #elsif char == Ncurses::KEY_ENTER
    elsif char == 10
      Ncurses.wmove @main, @main.getcury+1, 1 unless @main.getcury == @main.getmaxy-2
      #Ncurses.wprintw @main, "ENTER"
      Ncurses.wrefresh @main
    # OTHERWISE TYPE TO SCREEN
    else
      begin
        Ncurses.wprintw @main, char.chr
        #Ncurses.wprintw @main, @main.getcurx.to_s
        footnote ""
        Ncurses.wrefresh @main
      rescue
        #Ncurses.wprintw @main, "uh oh, bad key"
        #Ncurses.wrefresh @main
        footnote "uh oh, bad key"
      end
    end
  #rescue
  #end

end

Ncurses.endwin

