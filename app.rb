class Game
    WIN_COMBINATIONS = [ 
        [0,1,2], # top_row 
        [3,4,5], # middle_row 
        [6,7,8], # bottom_row 
        [0,3,6], # left_column 
        [1,4,7], # center_column 
        [2,5,8], # right_column 
        [0,4,8], # left_diagonal 
        [6,4,2] # right_diagonal 
        ]

    @@board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    def initialize()
        puts "What is the first player's name?"
        player1_name = gets.chomp
        @player1 = Player.new(player1_name)
        puts "What is the second player's name?"
        player2_name = gets.chomp
        @player2 = Player.new(player2_name)
        draw_board
        play
    end

    def draw_board
        puts "#{@@board[0]} | #{@@board[1]} | #{@@board[2]}"
        puts '------------'
        puts "#{@@board[3]} | #{@@board[4]} | #{@@board[5]}"
        puts '------------'
        puts "#{@@board[6]} | #{@@board[7]} | #{@@board[8]}"
        puts '------------'
    end

    def play
        turn = true

        while !victory?
            if turn
                puts "Player 1 pick the position you would like to play at? (1-9)"
                position = gets.chomp
                @@board[position.to_i - 1] = "X"
                turn = !turn
            elsif !turn
                puts "Player 2 pick the position you would like to play at? (1-9)"
                position = gets.chomp
                @@board[position.to_i - 1] = "O"
                turn = !turn
            end
            draw_board
        end
    end

    def victory?
        player1_positions = Array.new
        player2_positions = Array.new
        
        @@board.each_with_index do |piece_type, index|
            if piece_type == "X"
                player1_positions.push(index)
            elsif piece_type == "O"
                player2_positions.push(index)
            end
        end

        WIN_COMBINATIONS.each do |win_array|
            if (win_array - player1_positions).empty?
                return true
            elsif (win_array - player2_positions).empty?
                return true
            else
                return false
            end
        end
    end
end

class Player
    def initialize(name)
        @player_name = name
    end
end

game = Game.new()