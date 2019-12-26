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
    "1A": [0, 0],
    "2A": [1, 0],
    "3A": [2, 0],
    "1B": [0, 1],
    "2B": [1, 1],
    "3B": [2, 1],
    "1C": [0, 2],
    "2C": [1, 2],
    "3C": [2, 2],
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
        !!find_winner
    end

    def find_winner
        # horizontal winners
        board.each do |row|
            return row.first if find_winner_for_row row
        end
        # vertical winners
        [0, 1, 2].each do |col|
            row = [board[0][col], board[1][col], board[2][col]]
            return row.first if find_winner_for_row row
        end
        # diagonal winners
        backward_diag = [board[0][0], board[1][1], board[2][2]]
        forward_diag = [board[0][2], board[1][1], board[2][0]]
        return backward_diag.first if find_winner_for_row backward_diag
        return backward_diag.first if find_winner_for_row forward_diag

        return nil
    end

    private def find_winner_for_row(row)
        return row.first if row.uniq.length == 1 && row.none?(" ")
        return nil
    end

end
