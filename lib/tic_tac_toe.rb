require "pry"

class TicTacToe

    attr_accessor :play
    
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end
    
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end
  
    def input_to_index(spot)
        spot = spot.to_i - 1 
    end

    def move(index, token = "X")
        @board[index] = token
    end 

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(input)
        input.between?(0,8) && !position_taken?(input)
    end

    def turn
        index = input_to_index(gets.chomp)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end 

    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
                binding.pry
            end
          end
    end

    def full?
        @board.all?{|square| square != " " }
    end 

    def draw?
        full? && !won?
    end 

    def over?
        draw? || won?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"

    end
    
  end