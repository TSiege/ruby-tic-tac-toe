require "./board"

class Computer
  def self.take_turn(board)
    # take move
    best_move = self.find_best_move(board)
    board.take_space(*best_move, 'O')
  end

  def self.find_best_move(board)
    if (board.is_space_free?(1, 1))
      return [1, 1]
    end
    if (!board.is_space_free?(1, 1) && board.free_space_count == 8)
      return [0, 0] if board.is_space_free?(0, 0)
    end
    cloned_board = clone_board(board)
    for r in [0, 1, 2]
      for c in [0, 1, 2]
        cloned_board.take_space(r, c, 'O')
        if (cloned_board.find_winner === 'O')
          return [r, c]
        elsif (cloned_board.is_board_full?)
          return [r, c]
        else
          self.find_best_move(cloned_board)
          return [r, c]
        end
      end
    end
  end

  def self.clone_board(board)
    Board.new(board.board.map(&:clone))
  end
end
