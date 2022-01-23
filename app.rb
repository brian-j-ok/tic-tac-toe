class Game
    WIN_COMBINATIONS = [
        [0, 1, 2], # top_row
        [3, 4, 5], # middle_row
        [6, 7, 8], # bottom_row
        [0, 3, 6], # left_column
        [1, 4, 7], # center_column
        [2, 5, 8], # right_column
        [0, 4, 8], # left_diagonal
        [6, 4, 2] # right_diagonal
    ]

    @@board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @@winner = ""

    def initialize()
        puts "What is the first player's name?"
        player1_name = gets.chomp
        @player1 = Player.new(player1_name, "X")
        puts "What is the second player's name?"
        player2_name = gets.chomp
        @player2 = Player.new(player2_name, "O")
        draw_board
        play
    end

    def draw_board
        puts
        puts "#{@@board[0]} | #{@@board[1]} | #{@@board[2]}"
        puts '----------'
        puts "#{@@board[3]} | #{@@board[4]} | #{@@board[5]}"
        puts '----------'
        puts "#{@@board[6]} | #{@@board[7]} | #{@@board[8]}"
        puts '----------'
        puts
    end

    # TODO: See if you can rework the turn boolean into something cleaner
    def play
        turn = true

        while !victory?
            if turn
                player_move(@player1)
                turn = !turn
            elsif !turn
                player_move(@player2)
                turn = !turn
            end
            draw_board
        end

        puts "Congrats " + @@winner + "! You win the game!!!"
    end

    # TODO: Clean up if statement and error handling (specific feedback to user regarding why the input is invalid)
    def player_move (player)
        valid_move = false
        while !valid_move do
            puts player.player_name + "'s turn! At what position would you like to play?"
            position = gets.chomp
            if @@board[position.to_i - 1] != 'X' && @@board[position.to_i - 1] != 'O' && position.to_i < 10 && position.to_i > 0
                @@board[position.to_i - 1] = player.player_symbol
                valid_move = true
            else
                puts "Invalid input."
            end
        end
    end

    # TODO: Add a win count for repeat games
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
                @@winner = @player1.player_name
                return true
            elsif (win_array - player2_positions).empty?
                @@winner = @player2.player_name
                return true
            end
        end

        false
    end
end

# TODO: Store wincount in the player class
class Player
    attr_reader :player_name, :player_symbol

    def initialize(name, player_symbol)
        @player_name = name
        @player_symbol = player_symbol
    end
end

game = Game.new()