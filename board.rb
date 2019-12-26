TILE_TO_POSITION = {
    A1: [0, 0],
    A2: [1, 0],
    A3: [2, 0],
    B1: [0, 1],
    B2: [1, 1],
    B3: [2, 1],
    C1: [0, 2],
    C2: [1, 2],
    C3: [2, 2],
}

class Board
    attr_accessor :board

    def initialize
        self.reset
    end

    def reset
        @board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    end

    def print
        puts ["  A   B   C", *board.map.with_index { |r, i| "#{i + 1} #{r.join(" | ")}" }].join("\n")
    end

    def take_space(row, col, marker)
        raise "Invalid marker: #{marker}" if marker != "X" && marker != "O"
        board[row][col] = marker
    end

    def take_space_via_tile(tile, marker)
        position = TILE_TO_POSITION[tile.upcase.to_sym]
        raise "Invalid tile: #{tile}" if position.nil?
        take_space(*position, marker)
    end

    def is_space_free?(row, col)
        board[row][col] == " "
    end

    def is_board_full?
        board.flatten.none? { |x| x == " " }
    end

    def has_winner?
        # horizontal winners
        board.each do |row|
            return true if row.all? { |x| x == "X" } || row.all? { |x| x == "O" }
        end
        # vertical winners
        [0, 1, 2].each do |col|
            row = [board[0][col], board[1][col], board[2][col]]
            return true if row.all? { |x| x == "X" } || row.all? { |x| x == "O" }
        end
        # diagonal winners
        backward_diag = [board[0][0], board[1][1], board[2][2]]
        forward_diag = [board[0][2], board[1][1], board[2][0]]
        return true if backward_diag.all? { |x| x == "X" } || backward_diag.all? { |x| x == "O" }
        return true if forward_diag.all? { |x| x == "X" } || forward_diag.all? { |x| x == "O" }

        return false
    end

end
